Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014AFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=online.net header.i=@online.net header.b="CY71CYIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBEKrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:47:39 -0500
Received: from smtpauth-dc2.online.net ([62.210.16.40]:58150 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbfBEKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:47:39 -0500
X-Greylist: delayed 1586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 05:47:38 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=online.net; s=folays2;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; bh=SHAPVBHIZno1pHNWinSwByHHdMFnd/j/pNjmmwqpcXQ=;
        b=CY71CYInFdHXYsHnjNTny+qCtIWvB3sBekTWDY/dCbEBPlsV26DNm1qI7nJsw2eegUqIGeUi4rmCPqAAS/gI45Jg2JgyUpv6QxPVfNVJz9TqXi//DicdTl6pxQ05wzUQ6EDYfeM//H1u2mS9v5eQJJOATBFX0ae70nEhp5C/TMY=;
Received: from [185.18.169.48] (helo=FMAPORT)
        by smtpauth-dc2-1.online.net with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <frederic.mathieu@dualis.com>)
        id 1gqyGP-0001jk-1F
        for linux-kernel@vger.kernel.org; Tue, 05 Feb 2019 11:47:37 +0100
From:   =?iso-8859-1?Q?Fr=E9d=E9ric_Mathieu?= <frederic.mathieu@dualis.com>
To:     <linux-kernel@vger.kernel.org>
Subject: Kernel 4.9: strange behavior with fifo scheduler
Date:   Tue, 5 Feb 2019 11:47:30 +0100
Message-ID: <016801d4bd40$35c226e0$a14674a0$@dualis.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdS9P8JwIpkZgv/RQmuc53Ne6qlEBQ==
Content-Language: fr
X-auth-smtp-user: frederic.mathieu@dualis.com
X-online-auth-user: FLEX_T3lrcXlxVVFVU3FJV3dtUw==d61OTf1S1aB/NgqtdoUqA8P3ejmVSPpunu0/
X-online-auth-smtp: FLEX_a3FzR2tTc3FBc0V5dVkyeQ==IK/u75DQGCxTlm/XwfNvYrnFU5pq8MB9by+4+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on an X86_64 architecture (Intel(R) Core(TM) i3-6100U CPU @ 2.30GHz), I =
use
the linux kernel 4.9.146 with patch rt 125.
uname =96a: Linux 4.9.146-rt125 #1 SMP PREEMPT RT Tue Jan 29 14:17:55 =
CET 2019
x86_64 GNU/Linux

I observed a strange behavior of the scheduler when several tasks are
executed in FIFO mode on a CPU core and a significant CPU activity.

first test (reference: cpu load=3D0%):
cyclictest -m -D 5 -i 1000 -p 50 -a 0
      	# / dev / cpu_dma_latency set to 0us
      	policy: fifo: loadavg: 1.95 1.06 0.43 1/159 14305
      	T: 0 (14145) P: 50 I: 1000 C: 4997 Min: 7 Act: 7 Avg: 7 Max: 18
work fine

now, i'm loading the system on the cpu core 0 with a homemade process:
      cpu load 60%, sched FIFO prio 1, cpu 0
code snippet=20
      	active_time =3D 6000;
      	sleep_time =3D 4000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 do {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 clock_gettime(CLOCK_MONOTONIC, &start_time);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 // active =
loop=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 do {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for( =
cptdelay=3D0; cptdelay <
100; cptdelay++ );
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
clock_gettime(CLOCK_MONOTONIC, &now);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 diff=A0 =
=3D timespec_diff_us(
&start_time, &now );
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 } while (diff < active_time);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 // sleep : suspend time
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 usleep(sleep_time);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } while( 1 );


In this case cyclictest detects very long latencies
      cyclictest -m -D 5 -i 1000 -p 50 -a 0 -v=A0

Max CPUs =3D 2
# /dev/cpu_dma_latency set to 0us
Thread 0 Interval: 1500
       0:       0:      13
       0:       1:       8
       0:       2:       7
       0:       3:    5648
       0:       4:       8
       0:       5:       7
       0:       6:       7
       0:       7:       7
       0:       8:    5649
       0:       9:       7
       0:      10:       7
       0:      11:       7
       0:      12:       7
       0:      13:    5651
       0:      14:       7
       0:      15:       7
       0:      16:       7
       0:      17:       7
       0:      18:    5655
       0:      19:       7
       0:      20:       7
       0:      21:       7
       0:      22:       7
       0:      23:    5658
       0:      24:       7
       0:      25:       7
       0:      26:       7
       0:      27:       7
       0:      28:    5663
       0:      29:       7
       0:      30:       7
       0:      31:       7
       0:      32:       7
       0:      33:    5664
       0:      34:       7
       0:      35:       7
       0:      36:       7
       0:      37:       7
       0:      38:    5667
       0:      39:       7
       0:      40:       7
       0:      41:       7
       0:      42:       7
       0:      43:    5671
       0:      44:       8
       0:      45:       7
       0:      46:       7
       0:      47:       7
       0:      48:    5673
       0:      49:       7
       0:      50:       7
       0:      51:       7
       0:      52:       7
       0:      53:    5676
       0:      54:       7
       0:      55:       7
       0:      56:       7
       0:      57:       7
       0:      58:    5679
       0:      59:       7
       0:      60:       7
       0:      61:       7
       0:      62:       7
       0:      63:    5682
       0:      64:       7
       0:      65:       7
       0:      66:       7
       0:      67:       7
       0:      68:    5685


After verification, although no other process is running with real time
scheduler, I see a latency of about 5.6 ms at regular intervals.

it seems that the priority task 1 (fifo) is not pre-empted by the =
cyclictest
process with a priority of 50 (fifo) when the low priority task is =
active.=20
This =A0corresponds to the cycle recorded in the file: 6 ms of latency
followed by 4 "normal" latencies of 7 us.

Does anyone have any idea of this problem?

Best regards
Frederic MATHIEU


