Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221914-2-10389203821523544438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221913; b=Khaf+b+9cQOgdZwnsmh+VSIwyR3FHW72kl67HzER48ZstiA
    /BqgrGUAzSQOiudXqxc4XfIGHI1kJ2ruAn9t9yoO7ABerYNi7hm72sjTXqMhm4Dx
    Hm2u4DkB+qwqtu2EZkxnwUZN2yx737WPjV59tVF+s97iSNUInAL6sUPUTWUNtUPX
    fAqNRe4JjZ9Qr/1ZBFmKOoRci/B0lKy3FHGRJmgJ36LrdcSN2afjiHWpGO4003Qo
    qw7IPqbWc5QrBQ+dn7SW49r0IheyEwARMGQANiFLTf3RpuD4+gqAHLKdakTNRIQe
    i6kqVAWIIkS+H/tReazbCQs1+VOF5jR9YJvFjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221913; bh=J/gsuADVt69LxsjLbeWTDADInN
    BgyX8C8KnmF3gDRok=; b=Jsls6y8Vxg1crkVUNsZZzEKtV+gLQVKDLoZxUFz6qJ
    wsrS5tE9MurHflJI/VS0Wdpmha+NnF2Mj3iYub/1FYbGD8QqYkZCfM6wA9RZ6X6j
    oe4HgAAumLone0v1kM7jdFGIX8VzzYdpsvhITgizAdBtvMmNSJ2MoYeuj0AD+MNn
    wsu0eFKiVXd+aqm6PKZyw7jd5+850qMhhNxjtzTpJPj2pHDpvGrklAyfSRyu/7hX
    tZS0LGD5XE6vZ7p66ieX1mMl7fg1kS/3N3uFt05+p6YMGe+wjAvyphxzttyjEQEh
    V7f2c3jEZkPr2VnFAa2ncl9K0BfRrrpF6kdNVGEUZIOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeCPRiQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:38:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbeCPPXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 3.18 04/25] x86/MCE: Serialize sysfs changes
Date: Fri, 16 Mar 2018 16:22:51 +0100
Message-Id: <20180316152232.936014427@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seunghun Han <kkamagui@gmail.com>

commit b3b7c4795ccab5be71f080774c45bbbcc75c2aaf upstream.

The check_interval file in

  /sys/devices/system/machinecheck/machinecheck<cpu number>

directory is a global timer value for MCE polling. If it is changed by one
CPU, mce_restart() broadcasts the event to other CPUs to delete and restart
the MCE polling timer and __mcheck_cpu_init_timer() reinitializes the
mce_timer variable.

If more than one CPU writes a specific value to the check_interval file
concurrently, mce_timer is not protected from such concurrent accesses and
all kinds of explosions happen. Since only root can write to those sysfs
variables, the issue is not a big deal security-wise.

However, concurrent writes to these configuration variables is void of
reason so the proper thing to do is to serialize the access with a mutex.

Boris:

 - Make store_int_with_restart() use device_store_ulong() to filter out
   negative intervals
 - Limit min interval to 1 second
 - Correct locking
 - Massage commit message

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180302202706.9434-1-kkamagui@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -56,6 +56,9 @@ static DEFINE_MUTEX(mce_chrdev_read_mute
 			      rcu_read_lock_sched_held() || \
 			      lockdep_is_held(&mce_chrdev_read_mutex))
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -2183,6 +2186,7 @@ static ssize_t set_ignore_ce(struct devi
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2195,6 +2199,8 @@ static ssize_t set_ignore_ce(struct devi
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2207,6 +2213,7 @@ static ssize_t set_cmci_disabled(struct
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2218,6 +2225,8 @@ static ssize_t set_cmci_disabled(struct
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2225,8 +2234,19 @@ static ssize_t store_int_with_restart(st
 				      struct device_attribute *attr,
 				      const char *buf, size_t size)
 {
-	ssize_t ret = device_store_int(s, attr, buf, size);
+	unsigned long old_check_interval = check_interval;
+	ssize_t ret = device_store_ulong(s, attr, buf, size);
+
+	if (check_interval == old_check_interval)
+		return ret;
+
+	if (check_interval < 1)
+		check_interval = 1;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return ret;
 }
 
