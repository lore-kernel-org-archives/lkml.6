Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDPFvx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 01:51:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752982AbeDPFvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 01:51:52 -0400
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Wrong module .text address in 4.16.0
Organization: IBM LTC
Date: Mon, 16 Apr 2018 07:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041605-0012-0000-0000-000005CB3D09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041605-0013-0000-0000-000019477EFB
Message-Id: <7e17e3b1-25c3-cb61-ae94-dcbb1bf3473e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed 4.16.0 and discovered the module .text address is
wrong. It happens on s390 and x86 platforms. I have not tested others.

Here is the issue, I have used module qeth_l2 on s390 which is the
ethernet device driver:

root@s35lp76 ~]# lsmod
Module                  Size  Used by
qeth_l2                94208  1
...

[root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
qeth_l2 94208 1 - Live 0x000003ff80401000   <---- This is the correct address in memory
[root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text 
0x0000000018ea8363      <---- This is the wrong address
[root@s35lp76 ~]# 

File /sys/module/qeth_l2/sections/.text displays a very strange
address which is definitely wrong. It should be something like
0x000003ff80401xxx.

Same on x86.

I have checked file kernel/module.c function add_sect_attrs()
and it calls module_sect_show() when the sysfs file is read.
And module_sect_show() uses 

  sprintf(buf, "0x%pK\n", (void *)sattr->address);

and my sysctl setting should be correct:
[root@s35lp76 linux]# sysctl -a | fgrep kernel.kptr_restrict
kernel.kptr_restrict = 0
[root@s35lp76 linux]#

I wonder if somebody else has seen this issue?
Ideas how to fix this?

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
