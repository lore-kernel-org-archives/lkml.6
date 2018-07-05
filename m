Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3A4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B3221D63
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B3221D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytehouse.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeGEKY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:24:28 -0400
Received: from mail.tristarwebsolutions.co.uk ([188.191.154.26]:50767 "EHLO
        mail.tristarsupport.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeGEKY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:24:27 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 06:24:26 EDT
Received: from BytehousePC01 ([192.168.171.41])
        by mail.tristarsupport.co.uk (IceWarp 11.3.1.6 x64) with ASMTP (SSL) id 201807051118436660
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 11:18:43 +0100
From:   "Alan" <alan@bytehouse.co.uk>
To:     <linux-kernel@vger.kernel.org>
Subject: Weird SysRq's during reboot
Date:   Thu, 5 Jul 2018 11:18:49 +0100
Message-ID: <12ee01d41449$93254b50$b96fe1f0$@bytehouse.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdQUSVyFCio4MkrsTq6MTS6/f+drIA==
Content-Language: en-gb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone, this is my first time posting to this list so please be
gentle.

I have a server, hardware spec:

         HP DL360p G8
           2 x Intel Xeon E5-2620 Hex-Core 2GHz processors
           150GB Ram
           Embedded HP Ethernet 1Gb 4-port 331FLR Adapter
           Embedded Smart Array P420i Controller
           PCI-E Slot 1 HP Ethernet 10Gb 2-port 530SFP+ Adapter

which I am trying to configure as an OnApp compute engine. Recently I have
seen the following weird behaviour:

         1. Login on the server as root
         2. Enter a 'shutdown -r now' command
         3. Watch the reboot on the iLO console
         4. System reboots except that right at the end, after the login
prompt appears on the console, I see:

                  SysRq: Emergency Sync
                  Emergency Sync complete
                  SysRq : Emergency Remount R/O

              And then the system reboots again.
         5. The second reboot always works without the SysRq.

Looking in /var/log/messages I see, just prior to the second reboot (*):

         Jul  5 10:30:17 hv08 kernel: Ebtables v2.0 registered
         Jul  5 10:30:17 hv08 kernel: Bridge firewalling registered
         Jul  5 10:30:17 hv08 kernel: arp_tables: (C) 2002 David S. Miller
         Jul  5 10:30:18 hv08 kernel: lo: Disabled Privacy Extensions
*        Jul  5 10:30:27 hv08 kernel: SysRq : Emergency Sync
*        Jul  5 10:30:27 hv08 kernel: Emergency Sync complete
*        Jul  5 10:30:28 hv08 kernel: SysRq : Emergency Remount R/O
         Jul  5 10:33:43 hv08 kernel: imklog 5.8.10, log source = /proc/kmsg
started.
         Jul  5 10:33:43 hv08 rsyslogd: [origin software="rsyslogd"
swVersion="5.8.10" x-pid="2491" x-info="http://www.rsyslog.com"] start
         Jul  5 10:33:43 hv08 kernel: Initializing cgroup subsys cpuset
         Jul  5 10:33:43 hv08 kernel: Initializing cgroup subsys cpu
         Jul  5 10:33:43 hv08 kernel: Linux version
2.6.32-696.30.1.el6.x86_64 (mockbuild@c1bl.rdu2.centos.org) (gcc version
4.4.7 20120313 (Red Hat 4.4.7-18) (GCC) ) #1 SMP Tue May 22 03:28:18 UTC
2018
         Jul  5 10:33:43 hv08 kernel: Command line: ro
root=UUID=eafc533f-c5cb-4c89-bc0d-33125ab7f9d9 nomodeset rd_NO_LUKS
KEYBOARDTYPE=pc KEYTABLE=uk LANG=en_US.UTF-8 rd_NO_MD
SYSFONT=latarcyrheb-sun16 crash
kernel=auto rd_NO_LVM rd_NO_DM rhgb quiet

I have tried booting the 2.6.32-696.28.1.el6.x86_64  and the
2.6.32-696.el6.x86_64  kernels with the same result. The problem does not
occur if I boot from the Centos 6.9 liveDVD iso which also uses kernel
version 2.6.32-696.el6.x86_64.

So, I am hoping someone here can answer any of these questions for me:

         A. What have I done to make this happen?
         B. Is there a way I can fix it?
         C. If not is there some other way to stop it happening?

Thank you for taking the time to read this email. I shall look forward to
hearing from you. Please CC me on any replies.

Regards, Alan Griffiths

Bytehouse




