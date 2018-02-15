Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710042-2-14658811605148374751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710041; b=mAyYE41Xwp/Z7E5mD/X28k0s0KOJBXTbwcQHlIvjpqta8gd
    TBYXaqk7TNJAvemDa0csQTBB7WfhPDlYSIz/wZzdjCNhCmI77nwg3+QHDnkxARIV
    /UTHJ98xl/sUKym10dynhD8/53TIgKrFFt6reCoF1h4kSNpFv2afX23iadjG5DcE
    FBp4pPri2ov526vWx9yHOHFPaF32EGn5/PhyP8ApcCwRQ4fVy8woQXKTem7tcxT+
    sMi4mh7qgvuSE6UugS/dEi+DL2OL2PpPDGCZAg2f+tugQJMnJXbzvHUaHEuMMdLW
    dVpidoHsmaK1/N5I8CfTfDWtlc+nt4tNuePyR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710041; bh=4ip9nABXFrmBNiMO17swPhnHnP
    XyEr/TZlF1TT0pzKg=; b=G2ExF01LeBQOOlsDlyafdh1N/JcS0i9VKfaHNZva9O
    6jnw79i8XNT83y8pIuXkkgvmPX8SKC18St3b+HoR+46dLgUVlhyUQBvQDpIUzmUV
    nw1SqKi6dQ4g3RjkcgCfwqEuZyw575wU1Ad9fSv1/gUNNcIaUpqxT1kgUjpTczQs
    piI0Lxypxz9R9WyOd2+b5+AJ7B4dvcS2FU1prPW7DD2XS6mBEGx2QSwXhCs+65LV
    6297oHWNReZfYDPGPEl4yEf8ei6bYyThH2tiZg62aOlC09GQOqU+Mv/lGLQTJQjK
    bbBF+eRsBI0HBIl4iTbEu9Cgrs3il3MIWT7terisviTg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424582AbeBOPwB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:52:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424319AbeBOPro (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 198/202] devpts: fix error handling in devpts_mntget()
Date: Thu, 15 Feb 2018 16:18:18 +0100
Message-Id: <20180215151723.007375147@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit c9cc8d01fb04117928830449388512a5047569c9 upstream.

If devpts_ptmx_path() returns an error code, then devpts_mntget()
dereferences an ERR_PTR():

    BUG: unable to handle kernel paging request at fffffffffffffff5
    IP: devpts_mntget+0x13f/0x280 fs/devpts/inode.c:173

Fix it by returning early in the error paths.

Reproducer:

    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <sched.h>
    #include <sys/ioctl.h>
    #define TIOCGPTPEER _IO('T', 0x41)

    int main()
    {
        for (;;) {
            int fd = open("/dev/ptmx", 0);
            unshare(CLONE_NEWNS);
            ioctl(fd, TIOCGPTPEER, 0);
        }
    }

Fixes: 311fc65c9fb9 ("pty: Repair TIOCGPTPEER")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/devpts/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -168,11 +168,11 @@ struct vfsmount *devpts_mntget(struct fi
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(err);
+		return ERR_PTR(err);
 	}
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
-		path.mnt = ERR_PTR(-ENODEV);
+		return ERR_PTR(-ENODEV);
 	}
 	return path.mnt;
 }
