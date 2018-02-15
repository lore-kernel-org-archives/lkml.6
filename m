Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967542AbeBOKqe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:46:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966716AbeBOKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:46:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Behavior of powersave freq governor when cpu quota is set
From: "Ashutosh Mehra1" <asmehra1@in.ibm.com>
Date: Thu, 15 Feb 2018 16:16:26 +0530
MIME-Version: 1.0
X-KeepSent: 1AD6802D:9884CDA5-00258235:003AB24D;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 Octobe4, 2013
X-LLNOutbound: False
X-Disclaimed: 15147
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid: 18021510-7093-0000-0000-000005560741
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.394815; ST=0; TS=0; UL=0; ISC=; MB=0.099278
X-IBM-SpamModules-Versions: BY=3.00008539; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00990035; UDB=6.00502765; IPR=6.00769384;
 BA=6.00005830; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019568; XFM=3.00000015;
 UTC=2018-02-15 10:46:28
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2018-02-15 10:40:34 - 6.00008065
x-cbparentid: 18021510-7094-0000-0000-00003B0906EA
Message-Id: <OF1AD6802D.9884CDA5-ON00258235.003AB24D-65258235.003B2EAF@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand the effect of setting cpu.cpu_quota_us in cpu 
cgroup subsytem on application performance.
Essentially by reducing the CPU quota, but increasing the number of CPUs 
such that "effective" CPUs are still the same, would it impact the 
application? 
For example, is 4 CPU 100% quota configuration same as 8 CPU 50% quota 
configuration?

I have written a simple CPU-intensive program at 
https://github.com/ashu-mehra/cpu-quota-test and ran it under following 
cgroup configuration:
1) In cgroup which has 4 cpus and no limit on quota
2) In cgroup which has 8 cpus and 50% quota

When running this program for 32 threads I noticed following difference in 
the throughput reported by the program for the two configurations:

4CPU@100    8CPU@50
176236      87252.5

Performance of 8CPU@50 is less than half of what I get with 4CPU@100.
On debugging further, I noticed my system is configured to use "powersave" 
CPU freq governor. In this mode the CPU frequency of the cores when 
program is running on 4CPU@100 shot to maximum but for 8CPU@50 CPU 
frequence of the cores was much lower.
When I changed the CPU freq governor to "performance" (which is the only 
other freq governor available), performance with 8CPU@50 increases 
considerably as the cores started running at max frequency:

4CPU@100    8CPU@50
175804      163831

My system details are:
Ubuntu 16.04.2 LTS
Kernel 4.4.0-103-generic

Can someone please explain why is CPU frequency not increasing to max when 
"powersave" CPU freq governor is in use and CPU quota is set. Is this 
working as designed?

Regards,
Ashutosh Mehra
