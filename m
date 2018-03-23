Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805430-2-17510171170390579815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805429; b=M4CGNo3TG02mWWJaAenHQcfJsCAQFPVoul5RjMC9BglhcGN
    s/oSYuUz/5yWQt5dgbaRSC1G8gFjJrHOjJONZ0xcR0jJd2CT9UmzplkPkN176jEr
    vKSYHCxPJNG+juR005m+nBqHGJLrBKL2OI/gWWQRV9XfFtjaCFQreQjGlFhmYDUE
    vQvyv1XqbXsFnt8yeOlo9FbvN2DjrYpkCsED9MnaAwyh0Fuvmk4wio1f5BS0waHl
    Pqi88pccG/VEoeFosEdFPKPaZ3HW562fMoehb93BsEvfHdxhKfDoE8Lov0/Va3aN
    1XpF0963qSE6dCWQ713vlw0r0F06j0XfzxGCfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805429; bh=rUqkKCSn0Yq6yI4L9ugiygeog6
    6JMeZJ0h0d/8jR/+Y=; b=k2vPUt8LN2Lo364OOGHh1bQdC/THV7Wx9EJex42fwE
    7wK0J83VKJsfmbTq8fs00+M4fOehMMbjpl2jaJZSYqbZ8aELZculcm4U8v1emjuX
    531xugYInOdM57niiFVKbyrWDKbBLy4f8943kR7TTAd6ehuGOxrfuLg0Vm1XAznL
    smV2HTscJN7d9QAM+1caKn4iF/PI5vJmtEc9QDTLKiG9hcQy5p6mmQ/mqxbKiI4Q
    8nSnr2pGX9Pz1LoK75zymMRA+vS8UWoVNsxKDNa1IqNbj4Jdt4owQ97+rD0dB6Y3
    zYagjgYStPLIHaH94MIa6vc6k74obnvkzZTqv4QQAx3g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeCWLnb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:43:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeCWKDg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.14 76/77] kbuild: fix linker feature test macros when cross compiling with Clang
Date: Fri, 23 Mar 2018 10:54:50 +0100
Message-Id: <20180323094147.376418597@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit 86a9df597cdd564d2d29c65897bcad42519e3678 upstream.

I was not seeing my linker flags getting added when using ld-option when
cross compiling with Clang. Upon investigation, this seems to be due to
a difference in how GCC vs Clang handle cross compilation.

GCC is configured at build time to support one backend, that is implicit
when compiling.  Clang is explicit via the use of `-target <triple>` and
ships with all supported backends by default.

GNU Make feature test macros that compile then link will always fail
when cross compiling with Clang unless Clang's triple is passed along to
the compiler. For example:

$ clang -x c /dev/null -c -o temp.o
$ aarch64-linux-android/bin/ld -E temp.o
aarch64-linux-android/bin/ld:
unknown architecture of input file `temp.o' is incompatible with
aarch64 output
aarch64-linux-android/bin/ld:
warning: cannot find entry symbol _start; defaulting to
0000000000400078
$ echo $?
1

$ clang -target aarch64-linux-android- -x c /dev/null -c -o temp.o
$ aarch64-linux-android/bin/ld -E temp.o
aarch64-linux-android/bin/ld:
warning: cannot find entry symbol _start; defaulting to 00000000004002e4
$ echo $?
0

This causes conditional checks that invoke $(CC) without the target
triple, then $(LD) on the result, to always fail.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Kbuild.include |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -160,12 +160,13 @@ cc-if-fullversion = $(shell [ $(cc-fullv
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
 cc-ldoption = $(call try-run,\
-	$(CC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
 ld-option = $(call try-run,\
-	$(CC) -x c /dev/null -c -o "$$TMPO" ; $(LD) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+	$(CC) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
+	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
