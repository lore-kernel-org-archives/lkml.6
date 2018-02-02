Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591419-2-17279961897956018448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591415; b=WP96dhDZeV9UhLaVrKu+OMy+rAZD6BSV+UFBvzp2DdBCJcf
    D+C0jW3Wi8bKjjgGALazbtPLnZ2PS+mS/mfP0spALxC/LkXmTRkcFQz5tCA59acA
    joQzxa+Pd7Ftfi2hoVJr516bokVn7w5yMrbuKnQhmcePHJRRHFoNdw4lVNb2CDcg
    UPHxFhd8mcFO+e7YAF0jWd0L4FdSCXZBNYGUJHNqxyeOw8RJxtscpjbyo6BjvfYR
    eo3CfulICH6tVdzt76BDPNVGwbl/veD8PUP38zM5EOpvwxTb6q/XP4JKGeYuCXAB
    u82J90McMwywkGHN6MRdae5IL7aUTuEGdvgSLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591415; bh=YhWl6ZeOec0w/sSLdBD/oqmbUd
    oDWQTMz/rtI7ocyOM=; b=C0Io58OP3UTfKhPdS8D0x4bI88+Ka6dI9EYSt7f8Rx
    9pO2qF+223QCdxh/GFLujoO3W2tOgt9338vOEJEFsA/VrihruzmrLjpbD+VPPCNU
    iRMY1tKjwAgPMN6RYZ15JjL8s2MO1s3M8/BW+dr47istDaosQ0e1dY4/JjbVzc1w
    3WCCvElp18QVuOXwgpJ0q4AJB3VTxBixdE6lHIBZCu5aLOH1LQp480bwtLlwALFj
    6VruM4X2MdVIURceIsZFK/o1R5n0p7os4hvfMPv2/8QFpolTMywXQFl68Vn142R2
    +4mXnYRIA1vMB3HSPYIxqcADoc7F3kidqivnmusYT5bg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeBBRKM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeBBRKH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 035/156] cpupower : Fix cpupower working when cpu0 is offline
Date: Fri,  2 Feb 2018 17:56:56 +0100
Message-Id: <20180202140841.897364427@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Goel <huntbag@linux.vnet.ibm.com>


[ Upstream commit dbdc468f35ee827cab2753caa1c660bdb832243a ]

cpuidle_monitor used to assume that cpu0 is always online which is not
a valid assumption on POWER machines. This patch fixes this by getting
the cpu on which the current thread is running, instead of always using
cpu0 for monitoring which may not be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -130,15 +130,18 @@ static struct cpuidle_monitor *cpuidle_r
 {
 	int num;
 	char *tmp;
+	int this_cpu;
+
+	this_cpu = sched_getcpu();
 
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
+	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(this_cpu);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
 		return NULL;
 
 	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp = cpuidle_state_name(0, num);
+		tmp = cpuidle_state_name(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 
@@ -146,7 +149,7 @@ static struct cpuidle_monitor *cpuidle_r
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
 
-		tmp = cpuidle_state_desc(0, num);
+		tmp = cpuidle_state_desc(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);
