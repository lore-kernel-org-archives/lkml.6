Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C1B2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfAKIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:10:46 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:51666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfAKIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:10:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1B2DC6115;
        Fri, 11 Jan 2019 08:10:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: field83_233f9f6842661
X-Filterd-Recvd-Size: 13023
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Jan 2019 08:10:42 +0000 (UTC)
Message-ID: <6f3a66eb8edacd3b6813558e8a4e9220350b09d7.camel@perches.com>
Subject: [utility perl script] strncmp() -> str_has_prefix() conversions
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>
Date:   Fri, 11 Jan 2019 00:10:40 -0800
In-Reply-To: <20181221231924.4583e90b@vmware.local.home>
References: <20181221231924.4583e90b@vmware.local.home>
Content-Type: multipart/mixed; boundary="=-KygnV11JSGFAVPbcCxcO"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KygnV11JSGFAVPbcCxcO
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Fri, 2018-12-21 at 23:19 -0500, Steven Rostedt wrote:
> str_has_prefix

A coccinelle script could be more thorough but here
is a trivial perl script that can do most of the
	strncmp() -> str_has_prefix()
conversions where there is a constant string as one of
the first two arguments of strncmp like any of:

	strncmp(foo, "bar", 3)
	strncmp(foo, "bar", strlen("bar"))
	strncmp(foo, "bar", sizeof("bar") - 1)
	strncmp("foo", bar, 3)
	strncmp("foo", bar, strlen("foo"))
	strncmp("foo", bar",
sizeof("foo") - 1)

It could be used with a particular path or file:

$ git grep -w --name-only strncmp <path> | \
  grep -vP '^(tools|scripts)' | \
  while read file ; do \
    echo $file ; \
    perl -i ./strncmp.perl $file ; \
  done

It mostly works, but there are a few uses that
are not converted properly when the non const
string argument to strncmp is an expression like

	strncmp(a+b, "foo", 3)

There are also strncmp uses that remain after
this script is run where strncmp should just
be converted to strcmp instead like:

	strncmp(p, "foo", sizeof(foo))
and
	strncmp(p, "foo", 4)

The script converts the most common cases:

    ## counted length of string
    # strncmp(arg, string, counted length of string) == 0
    # strncmp(arg, string, counted length of string) != 0
    # !strncmp(arg, string, counted length of string)
    # strncmp(arg, string, counted length of string)

    ## Reversed string/arg counted length of string uses
    # strncmp(string, arg, counted length of string) == 0
    # strncmp(string, arg, counted length of string) != 0
    # !strncmp(string, arg, counted length of string)
    # strncmp(string, arg, counted length of string)

    ## strlen uses
    # strncmp(arg, string, strlen(string)) == 0
    # !strncmp(arg, string, strlen(string))

    ## reversed string/arg strlen uses
    # strncmp(string, arg, strlen(string)) == 0
    # !strncmp(string, arg, strlen(string))

    ## 'sizeof(string) - 1' uses
    # strncmp(arg, string, sizeof(string) - 1) == 0
    # !strncmp(arg, string, sizeof(string) - 1)


On linux-next, running the script below

$ git grep -w --name-only strncmp | \
  grep -vP '^(tools|scripts)' | \
  while read file ; do \
    echo $file ; \
    perl -i ./strncmp.perl $file ; \
  done

produces:

$ git diff --shortstat
 437 files changed, 1483 insertions(+), 1500 deletions(-)


--=-KygnV11JSGFAVPbcCxcO
Content-Type: application/x-perl; name="strncmp.perl"
Content-Disposition: attachment; filename="strncmp.perl"
Content-Transfer-Encoding: base64

b3VyICRJZGVudAk9IHFyewoJCQlbQS1aYS16X11bQS1aYS16XGRfXSoKCQkJKD86XHMqXCNcI1xz
KltBLVphLXpfXVtBLVphLXpcZF9dKikqCgkJfXg7Cm91ciAkTWVtYmVyCT0gcXJ7LT4kSWRlbnR8
XC4kSWRlbnR8XFtbXl1dKlxdfTsKb3VyICRMdmFsCT0gcXJ7JElkZW50KD86JE1lbWJlcikqfTsK
Cm91ciAkSW50X3R5cGUJPSBxcnsoP2kpbGx1fHVsbHxsbHxsdXx1bHxsfHV9OwpvdXIgJEJpbmFy
eQk9IHFyeyg/aSkwYlswMV0rJEludF90eXBlP307Cm91ciAkSGV4CT0gcXJ7KD9pKTB4WzAtOWEt
Zl0rJEludF90eXBlP307Cm91ciAkSW50CT0gcXJ7WzAtOV0rJEludF90eXBlP307Cm91ciAkT2N0
YWwJPSBxcnswWzAtN10rJEludF90eXBlP307Cm91ciAkU3RyaW5nCT0gcXJ7IlteIl0rIn07Cm91
ciAkRmxvYXRfaGV4CT0gcXJ7KD9pKTB4WzAtOWEtZl0rcC0/WzAtOV0rW2ZsXT99OwpvdXIgJEZs
b2F0X2RlYwk9IHFyeyg/aSkoPzpbMC05XStcLlswLTldKnxbMC05XSpcLlswLTldKykoPzplLT9b
MC05XSspP1tmbF0/fTsKb3VyICRGbG9hdF9pbnQJPSBxcnsoP2kpWzAtOV0rZS0/WzAtOV0rW2Zs
XT99OwpvdXIgJEZsb2F0CT0gcXJ7JEZsb2F0X2hleHwkRmxvYXRfZGVjfCRGbG9hdF9pbnR9Owpv
dXIgJENvbnN0YW50CT0gcXJ7JEZsb2F0fCRCaW5hcnl8JE9jdGFsfCRIZXh8JEludH07CgpvdXIg
JGJhbGFuY2VkX3BhcmVucyA9IHFyLyhcKCg/OlteXChcKV0rK3woPy0xKSkqXCkpLzsKb3VyICRM
dmFsT3JGdW5jCT0gcXJ7KCg/OltcJlwqXVxzKik/JEx2YWwpXHMqKCRiYWxhbmNlZF9wYXJlbnN7
MCwxfSlccyp9OwpvdXIgJEZ1bmNBcmcgPSBxcnsoJEx2YWxPckZ1bmN8JENvbnN0YW50fCRTdHJp
bmcpfTsKCmxvY2FsICQvOwp3aGlsZSAoPD4pIHsKICAgIG15ICRjb250ZW50ID0gJF87CgogICAg
IyMgY291bnRlZCBsZW5ndGggb2Ygc3RyaW5nCgogICAgIyBzdHJuY21wKGFyZywgc3RyaW5nLCBj
b3VudGVkIGxlbmd0aCBvZiBzdHJpbmcpID09IDAKICAgIHBvcygkY29udGVudCkgPSAwOwogICAg
d2hpbGUgKCRjb250ZW50ID1+IC9cYnN0cm5jbXBccypcKFxzKigkTHZhbE9yRnVuYylccyosXHMq
KCRTdHJpbmcpXHMqLFxzKigkSW50KVxzKlwpXHMqPT1ccyowXGIvZykgewoJbXkgJGFyZzEgPSAk
MTsKCW15ICRzdHJpbmcgPSAkNTsKCW15ICRsZW4gPSAkNjsKCWlmIChsZW5ndGgoJHN0cmluZykg
LSAyID09ICRsZW4pIHsKCSAgICAkY29udGVudCA9fiBzL1xic3RybmNtcFxzKlwoXHMqXFEkYXJn
MVxFLFxzKlxRJHN0cmluZ1xFXHMqLFxzKiRsZW5ccypcKVxzKj09XHMqMFxiL3N0cl9oYXNfcHJl
Zml4KCRhcmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAgIyBzdHJuY21wKGFyZywgc3RyaW5n
LCBjb3VudGVkIGxlbmd0aCBvZiBzdHJpbmcpICE9IDAKICAgIHBvcygkY29udGVudCkgPSAwOwog
ICAgd2hpbGUgKCRjb250ZW50ID1+IC9cYnN0cm5jbXBccypcKFxzKigkTHZhbE9yRnVuYylccyos
XHMqKCRTdHJpbmcpXHMqLFxzKigkSW50KVxzKlwpXHMqIT1ccyowXGIvZykgewoJbXkgJGFyZzEg
PSAkMTsKCW15ICRzdHJpbmcgPSAkNTsKCW15ICRsZW4gPSAkNjsKCWlmIChsZW5ndGgoJHN0cmlu
ZykgLSAyID09ICRsZW4pIHsKCSAgICAkY29udGVudCA9fiBzL1xic3RybmNtcFxzKlwoXHMqXFEk
YXJnMVxFLFxzKlxRJHN0cmluZ1xFXHMqLFxzKiRsZW5ccypcKVxzKiE9XHMqMFxiLyFzdHJfaGFz
X3ByZWZpeCgkYXJnMSwgJHN0cmluZykvOwoJfQogICAgfQoKICAgICMgIXN0cm5jbXAoYXJnLCBz
dHJpbmcsIGNvdW50ZWQgbGVuZ3RoIG9mIHN0cmluZykKICAgIHBvcygkY29udGVudCkgPSAwOwog
ICAgd2hpbGUgKCRjb250ZW50ID1+IC9cIVxzKnN0cm5jbXBccypcKFxzKigkTHZhbE9yRnVuYylc
cyosXHMqKCRTdHJpbmcpXHMqLFxzKihcZCspXHMqXCkvZykgewoJbXkgJGFyZzEgPSAkMTsKCW15
ICRzdHJpbmcgPSAkNTsKCW15ICRsZW4gPSAkNjsKCWlmIChsZW5ndGgoJHN0cmluZykgLSAyID09
ICRsZW4pIHsKCSAgICAkY29udGVudCA9fiBzL1whXHMqc3RybmNtcFxzKlwoXHMqXFEkYXJnMVxF
XHMqLFxzKlxRJHN0cmluZ1xFXHMqLFxzKiRsZW5ccypcKS9zdHJfaGFzX3ByZWZpeCgkYXJnMSwg
JHN0cmluZykvOwoJfQogICAgfQoKICAgICMgc3RybmNtcChhcmcsIHN0cmluZywgY291bnRlZCBs
ZW5ndGggb2Ygc3RyaW5nKQogICAgcG9zKCRjb250ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRl
bnQgPX4gL1xic3RybmNtcFxzKlwoXHMqKCRMdmFsT3JGdW5jKVxzKixccyooJFN0cmluZylccyos
XHMqKFxkKylccypcKS9nKSB7CglteSAkYXJnMSA9ICQxOwoJbXkgJHN0cmluZyA9ICQ1OwoJbXkg
JGxlbiA9ICQ2OwoJaWYgKGxlbmd0aCgkc3RyaW5nKSAtIDIgPT0gJGxlbikgewoJICAgICRjb250
ZW50ID1+IHMvXGJzdHJuY21wXHMqXChccypcUSRhcmcxXEVccyosXHMqXFEkc3RyaW5nXEVccyos
XHMqJGxlblxzKlwpLyFzdHJfaGFzX3ByZWZpeCgkYXJnMSwgJHN0cmluZykvOwoJfQogICAgfQoK
ICAgICMjIFJldmVyc2VkIHN0cmluZy9hcmcgY291bnRlZCBsZW5ndGggb2Ygc3RyaW5nIHVzZXMK
CiAgICAjIHN0cm5jbXAoc3RyaW5nLCBhcmcsIGNvdW50ZWQgbGVuZ3RoIG9mIHN0cmluZykgPT0g
MAogICAgcG9zKCRjb250ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRlbnQgPX4gL1xic3RybmNt
cFxzKlwoXHMqKCRTdHJpbmcpXHMqLFxzKigkTHZhbE9yRnVuYylccyosXHMqKCRJbnQpXHMqXClc
cyo9PVxzKjBcYi9nKSB7CglteSAkc3RyaW5nID0gJDE7CglteSAkYXJnMSA9ICQyOwoJbXkgJGxl
biA9ICQ2OwoJaWYgKGxlbmd0aCgkc3RyaW5nKSAtIDIgPT0gJGxlbikgewoJICAgICRjb250ZW50
ID1+IHMvXGJzdHJuY21wXHMqXChccypcUSRzdHJpbmdcRVxzKixccypcUSRhcmcxXEVccyosXHMq
JGxlblxzKlwpXHMqPT1ccyowXGIvc3RyX2hhc19wcmVmaXgoJGFyZzEsICRzdHJpbmcpLzsKCX0K
ICAgIH0KCiAgICAjIHN0cm5jbXAoc3RyaW5nLCBhcmcsIGNvdW50ZWQgbGVuZ3RoIG9mIHN0cmlu
ZykgIT0gMAogICAgcG9zKCRjb250ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRlbnQgPX4gL1xi
c3RybmNtcFxzKlwoXHMqKCRTdHJpbmcpXHMqLFxzKigkTHZhbE9yRnVuYylccyosXHMqKCRJbnQp
XHMqXClccyohPVxzKjBcYi9nKSB7CglteSAkc3RyaW5nID0gJDE7CglteSAkYXJnMSA9ICQyOwoJ
bXkgJGxlbiA9ICQ2OwoJaWYgKGxlbmd0aCgkc3RyaW5nKSAtIDIgPT0gJGxlbikgewoJICAgICRj
b250ZW50ID1+IHMvXGJzdHJuY21wXHMqXChccypcUSRzdHJpbmdcRVxzKixccypcUSRhcmcxXEUs
XHMqJGxlblxzKlwpXHMqIT1ccyowXGIvIXN0cl9oYXNfcHJlZml4KCRhcmcxLCAkc3RyaW5nKS87
Cgl9CiAgICB9CgogICAgIyAhc3RybmNtcChzdHJpbmcsIGFyZywgY291bnRlZCBsZW5ndGggb2Yg
c3RyaW5nKQogICAgcG9zKCRjb250ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRlbnQgPX4gL1wh
XHMqc3RybmNtcFxzKlwoXHMqKCRTdHJpbmcpXHMqLFxzKigkTHZhbE9yRnVuYylccyosXHMqKFxk
KylccypcKS9nKSB7CglteSAkc3RyaW5nID0gJDE7CglteSAkYXJnMSA9ICQyOwoJbXkgJGxlbiA9
ICQ2OwoJaWYgKGxlbmd0aCgkc3RyaW5nKSAtIDIgPT0gJGxlbikgewoJICAgICRjb250ZW50ID1+
IHMvXCFccypzdHJuY21wXHMqXChccypcUSRzdHJpbmdcRVxzKixccypcUSRhcmcxXEVccyosXHMq
JGxlblxzKlwpL3N0cl9oYXNfcHJlZml4KCRhcmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAg
IyBzdHJuY21wKHN0cmluZywgYXJnLCBjb3VudGVkIGxlbmd0aCBvZiBzdHJpbmcpCiAgICBwb3Mo
JGNvbnRlbnQpID0gMDsKICAgIHdoaWxlICgkY29udGVudCA9fiAvXGJzdHJuY21wXHMqXChccyoo
JFN0cmluZylccyosXHMqKCRMdmFsT3JGdW5jKVxzKixccyooXGQrKVxzKlwpL2cpIHsKCW15ICRz
dHJpbmcgPSAkMTsKCW15ICRhcmcxID0gJDI7CglteSAkbGVuID0gJDY7CglpZiAobGVuZ3RoKCRz
dHJpbmcpIC0gMiA9PSAkbGVuKSB7CgkgICAgJGNvbnRlbnQgPX4gcy9cYnN0cm5jbXBccypcKFxz
KlxRJHN0cmluZ1xFXHMqLFxzKlxRJGFyZzFcRVxzKixccyokbGVuXHMqXCkvIXN0cl9oYXNfcHJl
Zml4KCRhcmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAgIyMgc3RybGVuIHVzZXMKCiAgICAj
IHN0cm5jbXAoYXJnLCBzdHJpbmcsIHN0cmxlbihzdHJpbmcpKSA9PSAwCiAgICBwb3MoJGNvbnRl
bnQpID0gMDsKICAgIHdoaWxlICgkY29udGVudCA9fiAvXGJzdHJuY21wXHMqXChccyooJEx2YWxP
ckZ1bmMpXHMqLFxzKigkU3RyaW5nKVxzKixccypzdHJsZW5ccypcKFxzKigkU3RyaW5nKVxzKlwp
XHMqPT1ccyowXGIvZykgewoJbXkgJGFyZzEgPSAkMTsKCW15ICRzdHJpbmcgPSAkNTsKCW15ICRz
aXplb2Zfc3RyaW5nID0gJDY7CglpZiAoJHN0cmluZyA9PSAkc2l6ZW9mX3N0cmluZykgewoJICAg
ICRjb250ZW50ID1+IHMvXGJzdHJuY21wXHMqXChccypcUSRhcmcxXEVccyosXHMqXFEkc3RyaW5n
XEVccyosXHMqc3RybGVuXHMqXChccypcUSRzaXplb2Zfc3RyaW5nXEVccypcKVxzKj09XHMqMFxi
L3N0cl9oYXNfcHJlZml4KCRhcmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAgIyAhc3RybmNt
cChhcmcsIHN0cmluZywgc3RybGVuKHN0cmluZykpCiAgICBwb3MoJGNvbnRlbnQpID0gMDsKICAg
IHdoaWxlICgkY29udGVudCA9fiAvXCFccypzdHJuY21wXHMqXChccyooJEx2YWxPckZ1bmMpXHMq
LFxzKigkU3RyaW5nKVxzKixccypzdHJsZW5ccypcKFxzKigkU3RyaW5nKVxzKlwpXHMqXCkvZykg
ewoJbXkgJGFyZzEgPSAkMTsKCW15ICRzdHJpbmcgPSAkNTsKCW15ICRzaXplb2Zfc3RyaW5nID0g
JDY7CglpZiAoJHN0cmluZyA9PSAkc2l6ZW9mX3N0cmluZykgewoJICAgICRjb250ZW50ID1+IHMv
XCFccypzdHJuY21wXHMqXChccypcUSRhcmcxXEUsXHMqXFEkc3RyaW5nXEVccyosXHMqc3RybGVu
XHMqXChccypcUSRzaXplb2Zfc3RyaW5nXEVccypcKVxzKlwpL3N0cl9oYXNfcHJlZml4KCRhcmcx
LCAkc3RyaW5nKS87Cgl9CiAgICB9CgoKICAgICMjIHJldmVyc2VkIHN0cmxlbiB1c2VzCgogICAg
IyBzdHJuY21wKHN0cmluZywgYXJnLCBzdHJsZW4oc3RyaW5nKSkgPT0gMAogICAgcG9zKCRjb250
ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRlbnQgPX4gL1xic3RybmNtcFxzKlwoXHMqKCRTdHJp
bmcpXHMqLFxzKigkTHZhbE9yRnVuYylccyosXHMqc3RybGVuXHMqXChccyooJFN0cmluZylccypc
KVxzKj09XHMqMFxiL2cpIHsKCW15ICRzdHJpbmcgPSAkMTsKCW15ICRhcmcxID0gJDI7CglteSAk
c2l6ZW9mX3N0cmluZyA9ICQ2OwoJaWYgKCRzdHJpbmcgPT0gJHNpemVvZl9zdHJpbmcpIHsKCSAg
ICAkY29udGVudCA9fiBzL1xic3RybmNtcFxzKlwoXHMqXFEkc3RyaW5nXEVccyosXHMqXFEkYXJn
MVxFXHMqLFxzKnN0cmxlblxzKlwoXHMqXFEkc2l6ZW9mX3N0cmluZ1xFXHMqXClccyo9PVxzKjBc
Yi9zdHJfaGFzX3ByZWZpeCgkYXJnMSwgJHN0cmluZykvOwoJfQogICAgfQoKICAgICMgIXN0cm5j
bXAoc3RyaW5nLCBhcmcsIHN0cmxlbihzdHJpbmcpKQogICAgcG9zKCRjb250ZW50KSA9IDA7CiAg
ICB3aGlsZSAoJGNvbnRlbnQgPX4gL1whXHMqc3RybmNtcFxzKlwoXHMqKCRTdHJpbmcpXHMqLFxz
KigkTHZhbE9yRnVuYylccyosXHMqc3RybGVuXHMqXChccyooJFN0cmluZylccypcKVxzKlwpL2cp
IHsKCW15ICRzdHJpbmcgPSAkMTsKCW15ICRhcmcxID0gJDI7CglteSAkc2l6ZW9mX3N0cmluZyA9
ICQ2OwoJaWYgKCRzdHJpbmcgPT0gJHNpemVvZl9zdHJpbmcpIHsKCSAgICAkY29udGVudCA9fiBz
L1whXHMqc3RybmNtcFxzKlwoXHMqXFEkc3RyaW5nXEVccyosXHMqXFEkYXJnMVxFLFxzKnN0cmxl
blxzKlwoXHMqXFEkc2l6ZW9mX3N0cmluZ1xFXHMqXClccypcKS9zdHJfaGFzX3ByZWZpeCgkYXJn
MSwgJHN0cmluZykvOwoJfQogICAgfQoKCiAgICAjIyAnc2l6ZW9mKHN0cmluZykgLSAxJyB1c2Vz
CgogICAgIyBzdHJuY21wKGFyZywgc3RyaW5nLCBzaXplb2Yoc3RyaW5nKSAtIDEpID09IDAKICAg
IHBvcygkY29udGVudCkgPSAwOwogICAgd2hpbGUgKCRjb250ZW50ID1+IC9cYnN0cm5jbXBccypc
KFxzKigkTHZhbE9yRnVuYylccyosXHMqKCRTdHJpbmcpXHMqLFxzKnNpemVvZlxzKlwoXHMqKCRT
dHJpbmcpXHMqXClccypcLVxzKjFccypcKVxzKj09XHMqMFxiL2cpIHsKCW15ICRhcmcxID0gJDE7
CglteSAkc3RyaW5nID0gJDU7CglteSAkc2l6ZW9mX3N0cmluZyA9ICQ2OwoJaWYgKCRzdHJpbmcg
PT0gJHNpemVvZl9zdHJpbmcpIHsKCSAgICAkY29udGVudCA9fiBzL1xic3RybmNtcFxzKlwoXHMq
XFEkYXJnMVxFXHMqLFxzKlxRJHN0cmluZ1xFXHMqLFxzKnNpemVvZlxzKlwoXHMqXFEkc2l6ZW9m
X3N0cmluZ1xFXHMqXClccypcLVxzKjFccypcKVxzKj09XHMqMFxiL3N0cl9oYXNfcHJlZml4KCRh
cmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAgIyAhc3RybmNtcChhcmcsIHN0cmluZywgc2l6
ZW9mKHN0cmluZykgLSAxKQogICAgcG9zKCRjb250ZW50KSA9IDA7CiAgICB3aGlsZSAoJGNvbnRl
bnQgPX4gL1whXHMqc3RybmNtcFxzKlwoXHMqKCRMdmFsT3JGdW5jKVxzKixccyooJFN0cmluZylc
cyosXHMqc2l6ZW9mXHMqXChccyooJFN0cmluZylccypcKVxzKi1ccyoxXHMqXCkvZykgewoJbXkg
JGFyZzEgPSAkMTsKCW15ICRzdHJpbmcgPSAkNTsKCW15ICRzaXplb2Zfc3RyaW5nID0gJDY7Cglp
ZiAoJHN0cmluZyA9PSAkc2l6ZW9mX3N0cmluZykgewoJICAgICRjb250ZW50ID1+IHMvXCFccypz
dHJuY21wXHMqXChccypcUSRhcmcxXEUsXHMqXFEkc3RyaW5nXEVccyosXHMqc2l6ZW9mXHMqXChc
cypcUSRzaXplb2Zfc3RyaW5nXEVccypcKVxzKlwtXHMqMVxzKlwpL3N0cl9oYXNfcHJlZml4KCRh
cmcxLCAkc3RyaW5nKS87Cgl9CiAgICB9CgogICAgcHJpbnQgJGNvbnRlbnQ7Cn0K


--=-KygnV11JSGFAVPbcCxcO--

