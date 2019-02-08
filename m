Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44983C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15000218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfBHV53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:57:29 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46928 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726244AbfBHV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:57:29 -0500
Received: (qmail 7717 invoked by uid 2102); 8 Feb 2019 16:57:27 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Feb 2019 16:57:27 -0500
Date:   Fri, 8 Feb 2019 16:57:27 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <87ftszqa7k.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1902081652080.1482-200000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1559625215-774301561-1549663047=:1482"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1559625215-774301561-1549663047=:1482
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Feb 2019, Eric W. Biederman wrote:

> The usb support for asyncio encoded one of it's values in the wrong
> field.  It should have used si_value but instead used si_addr which is
> not present in the _rt union member of struct siginfo.
> 
> The result is a POSIX and glibc incompatible encoding of fields in
> struct siginfo with si_code of SI_ASYNCIO.  This makes it impossible
> to look at a struct siginfo with si_code set to SI_ASYNCIO and without
> context properly decode it.  Which unfortunately means that
> copy_siginfo_to_user32 can't handle the compat issues this unfortunate
> choice in encodings brings up.
> 
> Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
> dedicated function for this one specific case.  There are no other
> users of kill_pid_info_as_cred so this specialization should have no
> impact on the amont of code in the kernel.  Have kill_pid_usb_asyncio
> take instead of a siginfo_t which is difficult error prone 3
> arguments, a signal number, an errno value, and an address enconded as
> a sigval_t.  The encoding as a sigval_t allows the caller to deal with
> the compat issues before calling kill_pid_info_as_cred.
> 
> Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
> the pointer value at the in si_pid (instead of si_addr) and get
> the same binary result when the structure is copied to user space
> and when the structure is copied field by field.
> 
> The usb code is updated to track if the values it passes into
> kill_pid_usb_asyncio were passed to it from a native userspace
> or from at compat user space.  To allow a proper conversion
> of the addresses.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Oliver Neukum <oneukum@suse.com>
> Fixes: v2.3.39
> Cc: stable@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Can I get someone to test this code?  I just discovered that the
> usb code is filling in struct siginfo wrong and copy_siginfo_to_user32
> can't possibly get this correct without some help.
> 
> I think I have coded up a working fix.  But I don't have a setup
> where I can test this.

Eric:

You should be able to test this patch by running the attached 
program.  It takes one argument, the pathname to a USB device file.  
For example, on my system:

# ./usbsig /dev/bus/usb/001/001
Got signal 10, signo 10 errno 0 code -4

I don't know exactly what you're looking for, but it should be pretty 
easy to modify the test program however you want.

If you need to test the compatibility mode specifically, I can do that
here -- I'm running a 32-bit userspace on a 64-bit kernel.  But you'll
have to tell me exactly what test code to run.

Alan Stern

---1559625215-774301561-1549663047=:1482
Content-Type: TEXT/plain; name="usbsig.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L0.1902081657270.1482@iolanthe.rowland.org>
Content-Description: 
Content-Disposition: attachment; filename="usbsig.c"

LyogdXNic2lnLmMgLS0gdGVzdCBVU0IgYXN5bmMgc2lnbmFsIGRlbGl2ZXJ5
ICovDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPGZjbnRsLmg+
DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQoj
aW5jbHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQoj
aW5jbHVkZSA8bGludXgvdXNiL2NoOS5oPg0KI2luY2x1ZGUgPGxpbnV4L3Vz
YmRldmljZV9mcy5oPg0KDQp2b2lkIGhhbmRsZXIoaW50IHNpZywgc2lnaW5m
b190ICppbmZvICwgdm9pZCAqdWNvbnRleHQpDQp7DQoJdWNvbnRleHRfdCAq
Y29uID0gKHVjb250ZXh0X3QgKikgdWNvbnRleHQ7DQoNCglwcmludGYoIkdv
dCBzaWduYWwgJWQsIHNpZ25vICVkIGVycm5vICVkIGNvZGUgJWRcbiIsDQoJ
CQlzaWcsIGluZm8tPnNpX3NpZ25vLCBpbmZvLT5zaV9lcnJubywgaW5mby0+
c2lfY29kZSk7DQp9DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikNCnsNCgljaGFyICpkZXZmaWxlbmFtZTsNCglpbnQgZmQ7DQoJaW50IHJj
Ow0KCXN0cnVjdCBzaWdhY3Rpb24gYWN0Ow0KCXN0cnVjdCB1c2JkZXZmc191
cmIgdXJiOw0KCXN0cnVjdCB1c2JfY3RybHJlcXVlc3QgKnJlcTsNCgl2b2lk
ICpwdHI7DQoJY2hhciBidWZbODBdOw0KDQoJaWYgKGFyZ2MgIT0gMikgew0K
CQlmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiB1c2JzaWcgZGV2aWNlLWZpbGUt
bmFtZVxuIik7DQoJCXJldHVybiAxOw0KCX0NCg0KCWRldmZpbGVuYW1lID0g
YXJndlsxXTsNCglmZCA9IG9wZW4oZGV2ZmlsZW5hbWUsIE9fUkRXUik7DQoJ
aWYgKGZkID09IC0xKSB7DQoJCXBlcnJvcigiRXJyb3Igb3BlbmluZyBkZXZp
Y2UgZmlsZSIpOw0KCQlyZXR1cm4gMTsNCgl9DQoNCglhY3Quc2Ffc2lnYWN0
aW9uID0gaGFuZGxlcjsNCglzaWdlbXB0eXNldCgmYWN0LnNhX21hc2spOw0K
CWFjdC5zYV9mbGFncyA9IFNBX1NJR0lORk87DQoNCglyYyA9IHNpZ2FjdGlv
bihTSUdVU1IxLCAmYWN0LCBOVUxMKTsNCglpZiAocmMgPT0gLTEpIHsNCgkJ
cGVycm9yKCJFcnJvciBpbiBzaWdhY3Rpb24iKTsNCgkJcmV0dXJuIDE7DQoJ
fQ0KDQoJbWVtc2V0KCZ1cmIsIDAsIHNpemVvZih1cmIpKTsNCgl1cmIudHlw
ZSA9IFVTQkRFVkZTX1VSQl9UWVBFX0NPTlRST0w7DQoJdXJiLmVuZHBvaW50
ID0gVVNCX0RJUl9JTiB8IDA7DQoJdXJiLmJ1ZmZlciA9IGJ1ZjsNCgl1cmIu
YnVmZmVyX2xlbmd0aCA9IHNpemVvZihidWYpOw0KCXVyYi5zaWduciA9IFNJ
R1VTUjE7DQoNCglyZXEgPSAoc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqKSBi
dWY7DQoJcmVxLT5iUmVxdWVzdFR5cGUgPSBVU0JfRElSX0lOIHwgVVNCX1RZ
UEVfU1RBTkRBUkQgfCBVU0JfUkVDSVBfREVWSUNFOw0KCXJlcS0+YlJlcXVl
c3QgPSBVU0JfUkVRX0dFVF9ERVNDUklQVE9SOw0KCXJlcS0+d1ZhbHVlID0g
VVNCX0RUX0RFVklDRSA8PCA4Ow0KCXJlcS0+d0luZGV4ID0gMDsNCglyZXEt
PndMZW5ndGggPSBzaXplb2YoYnVmKSAtIHNpemVvZigqcmVxKTsNCg0KCXJj
ID0gaW9jdGwoZmQsIFVTQkRFVkZTX1NVQk1JVFVSQiwgJnVyYik7DQoJaWYg
KHJjID09IC0xKSB7DQoJCXBlcnJvcigiRXJyb3IgaW4gU1VCTUlUVVJCIGlv
Y3RsIik7DQoJCXJldHVybiAxOw0KCX0NCg0KCXJjID0gaW9jdGwoZmQsIFVT
QkRFVkZTX1JFQVBVUkIsICZwdHIpOw0KCWlmIChyYyA9PSAtMSkgew0KCQlw
ZXJyb3IoIkVycm9yIGluIFJFQVBVUkIgaW9jdGwiKTsNCgkJcmV0dXJuIDE7
DQoJfQ0KDQoJY2xvc2UoZmQpOw0KCXJldHVybiAwOw0KfQ0K
---1559625215-774301561-1549663047=:1482--
