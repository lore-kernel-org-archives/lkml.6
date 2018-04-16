Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeDPGXf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:23:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753346AbeDPGXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:23:34 -0400
Subject: Re: Wrong module .text address in 4.16.0
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
References: <7e17e3b1-25c3-cb61-ae94-dcbb1bf3473e@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Mon, 16 Apr 2018 08:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7e17e3b1-25c3-cb61-ae94-dcbb1bf3473e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041606-0044-0000-0000-000005489E32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041606-0045-0000-0000-00002888A3B9
Message-Id: <3836add7-8691-77c1-33d2-0fbee7051795@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160059
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, this breaks at least perf capability to resolve module symbols.
Adding some more CCs for perf and module.


On 04/16/2018 07:51 AM, Thomas-Mich Richter wrote:
> I just installed 4.16.0 and discovered the module .text address is
> wrong. It happens on s390 and x86 platforms. I have not tested others.
> 
> Here is the issue, I have used module qeth_l2 on s390 which is the
> ethernet device driver:
> 
> root@s35lp76 ~]# lsmod
> Module                  Size  Used by
> qeth_l2                94208  1
> ...
> 
> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
> qeth_l2 94208 1 - Live 0x000003ff80401000   <---- This is the correct address in memory
> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text 
> 0x0000000018ea8363      <---- This is the wrong address
> [root@s35lp76 ~]# 
> 
> File /sys/module/qeth_l2/sections/.text displays a very strange
> address which is definitely wrong. It should be something like
> 0x000003ff80401xxx.
> 
> Same on x86.
> 
> I have checked file kernel/module.c function add_sect_attrs()
> and it calls module_sect_show() when the sysfs file is read.
> And module_sect_show() uses 
> 
>   sprintf(buf, "0x%pK\n", (void *)sattr->address);
> 
> and my sysctl setting should be correct:
> [root@s35lp76 linux]# sysctl -a | fgrep kernel.kptr_restrict
> kernel.kptr_restrict = 0
> [root@s35lp76 linux]#
> 
> I wonder if somebody else has seen this issue?
> Ideas how to fix this?
> 
> Thanks
> 
