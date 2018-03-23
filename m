Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802485-2-6292106131538215999
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
    t=1521802485; b=QUYrCgARWVLPQeMq+kSMov/UVqOMOEDEl+EgNiI3Mj9jZrd
    wI1/j6XFCCNzCSnKnyNwF6hhIwnZUWCIfyrZjT9Xt22uYrUJ65q8Q9r1Z1MHpydF
    FKZy1D2V1r/qcocBApiH+3CfqsPxNbhNbJrd0IXg8cmmjHvBlDR+tlgaq1aUdYEv
    6hEtG24hsd04Qv8VifP8q5Eb+T4Q3KEou6i+4imLynnlx7gTnvnjP+17wfExD/oW
    +Bpfou+VfPLsqrCvqBYIpuhAhWM0iysNZGrIeosju96gaTil49mnbH5DYPxElLlc
    SfUs8jf82MjECkSqrVvtw7xbMfvlKg8SvZZZLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802485; bh=ALjsDzKmvOKYRsFsNX+Gm6Rn9Y
    leBzaF6iaJKr56b+M=; b=Lm6j328ApWPTWdcap6aZFSXPoNzR3qSv7BLT7u818o
    FjoMkQqrm1eht0hWIKT1ZQWz+v3WvYTvw/AIaX9xF0YmWg+HTlg43N2vDh/q26p9
    W45alC5C/2pXrMK1NLL83Y/K/wEh5FjXK1lA1Yjur2qhidMThHtW+abC67WrVjQk
    oiH2iigYGRzYuHfwsONF9cHkwEm6/uetDetgJJ+dBFFQ3aI0McpYGDYx9H8h763C
    ezFE8dhvrC20ydzvCcsR9UofHaTXKjGjH85izUCgaOfTmLM24Pi53qKbYtxR08Ua
    uO2w99zDn6t2OO/7lmQmcwdyjRcYJhDJL7UpisPuqE2A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1755875AbeCWKNa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeCWKN2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com,
        Yisheng Xie <xieyisheng1@huawei.com>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: [PATCH 4.4 05/97] staging: android: ashmem: Fix possible deadlock in ashmem_ioctl
Date: Fri, 23 Mar 2018 10:53:52 +0100
Message-Id: <20180323094157.843632674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

commit 740a5759bf222332fbb5eda42f89aa25ba38f9b2 upstream.

ashmem_mutex may create a chain of dependencies like:

CPU0                                    CPU1
 mmap syscall                           ioctl syscall
 -> mmap_sem (acquired)                 -> ashmem_ioctl
 -> ashmem_mmap                            -> ashmem_mutex (acquired)
    -> ashmem_mutex (try to acquire)       -> copy_from_user
                                              -> mmap_sem (try to acquire)

There is a lock odering problem between mmap_sem and ashmem_mutex causing
a lockdep splat[1] during a syzcaller test. This patch fixes the problem
by move copy_from_user out of ashmem_mutex.

[1] https://www.spinics.net/lists/kernel/msg2733200.html

Fixes: ce8a3a9e76d0 (staging: android: ashmem: Fix a race condition in pin ioctls)
Reported-by: syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -703,16 +703,14 @@ static int ashmem_pin_unpin(struct ashme
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
+		return -EFAULT;
+
 	mutex_lock(&ashmem_mutex);
 
 	if (unlikely(!asma->file))
 		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
