Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640EB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="S0OchZwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640EB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbeKTJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:01:11 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:39716 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730290AbeKTJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:01:11 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id wAJMVkfK031411;
        Mon, 19 Nov 2018 22:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=jan2016.eng;
 bh=fR7w9eKOfadedwofODg8KMuk3N4I/GM94hsdonx37Jk=;
 b=S0OchZwjwwSVLkvxMl27tPfTEj03e771Tyu0LWwxjhP4bZG04nLWiBt135HoDnjRJ3PJ
 Do040XyaIloT5y9ki4cU8eRRAcjrxuE5VcSL7ITUD4mUi0UOPsqirT7EkvVSJFrx9pil
 97Yw7EEIa6fU1cILZSa4SfSztxOHEGL/6iD3G65raM+X4y7gokg3A6SE1KejJmSLi5bZ
 pTppc973nulvX47zFTvVJKlnF1TS+B7oTu8P4qndHy2UlziZOsswaZhMyES2k3pwu4A5
 vICkSUkIIVzK2LK4Qc1MauxTHzxiipTFe9XtDC9qSvfNd+abY3pB2DZHwZM0eslE2LNz 4A== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by m0050102.ppops.net-00190b01. with ESMTP id 2nuwy6hndr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Nov 2018 22:35:10 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wAJMZ4uF017608;
        Mon, 19 Nov 2018 17:35:09 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2ntf703f6t-1;
        Mon, 19 Nov 2018 17:35:09 -0500
Received: from [0.0.0.0] (prod-ssh-gw02.sanmateo.corp.akamai.com [172.22.187.166])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 641201FCD8;
        Mon, 19 Nov 2018 22:35:08 +0000 (GMT)
To:     tglx@linutronix.de
Cc:     saeedm@mellanox.com, linux-kernel@vger.kernel.org,
        "Ozen, Gurhan" <guozen@akamai.com>
From:   Josh Hunt <johunt@akamai.com>
Subject: vector space exhaustion on 4.14 LTS kernels
Message-ID: <598457c6-4bea-50f5-efe9-6a2af3405ff5@akamai.com>
Date:   Mon, 19 Nov 2018 14:35:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811190199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

We have a class of machines that appear to be exhausting the vector 
space on cpus 0 and 1 which causes some breakage later on when trying to 
set the affinity. The boxes are running the 4.14 LTS kernel.

I instrumented 4.14 and here's what I see:

[   28.328849] __assign_irq_vector: irq:512 cpu:0 mask:ff,ffffffff 
onlinemask:ff,ffffffff vector:0
[   28.329847] __assign_irq_vector: irq:512 cpu:2 vector:222 cfgvect:0 
off:14 old_domain:00,00000000 domain:00,00000000 
vector_search:00,00000004 update
[   28.329847] default_cpu_mask_to_apicid: irq:512 mask:00,00000004
...
[   31.729154] __assign_irq_vector: irq:512 cpu:0 mask:ff,ffffffff 
onlinemask:ff,ffffffff vector:222
[   31.729154] __assign_irq_vector: irq:512 cpu:0 mask:ff,ffffffff 
vector_cpumask:00,00000001 vector:222
...
[   31.729154] __assign_irq_vector: irq:512 cpu:2 vector:00,00000004 
domain:00,00000004 success
[   31.729154] default_cpu_mask_to_apicid: irq:512 hwirq:512 
mask:00,00000004
[   31.729154] apic_set_affinity: irq:512 mask:ff,ffffffff err:0
...
[   32.818152] mlx5_irq_set_affinity_hint: 0: irq:512 mask:00,00000001
...
[   39.531242] __assign_irq_vector: irq:512 cpu:0 mask:00,00000001 
onlinemask:ff,ffffffff vector:222
[   39.531244] __assign_irq_vector: irq:512 cpu:0 mask:00,00000001 
vector_cpumask:00,00000001 vector:222
[   39.531245] __assign_irq_vector: irq:512 cpu:0 vector:00,00000001 
domain:00,00000004
...
[   39.531384] __assign_irq_vector: irq:512 cpu:0 vector:37 
current_vector:37 next_cpu2
[   39.531385] __assign_irq_vector: irq:512 cpu:128 searched:00,00000001 
vector:00,00000000 continue
[   39.531386] apic_set_affinity: irq:512 mask:00,00000001 err:-28

The affinity values:

root@172.25.48.208:/proc/irq/512# grep . *
affinity_hint:00,00000001
effective_affinity:00,00000004
effective_affinity_list:2
grep: mlx5_comp0@pci:0000:65:00.1: Is a directory
node:0
smp_affinity:ff,ffffffff
smp_affinity_list:0-39
spurious:count 3
spurious:unhandled 0
spurious:last_unhandled 0 ms

I noticed your change, a0c9259dc4e1 "irq/matrix: Spread interrupts on 
allocation", and this sounds like what we're hitting. Booting 4.19 does 
not have this problem. I haven't booted 4.15 yet, but can do it to 
confirm the above commit is what resolves this.

Since 4.14 doesn't have the matrix allocator it's not a trivial 
backport. I was wondering a) if you agree with my assessment and b) if 
there's any plans on resolving this on the 4.14 allocator? If not I can 
attempt to backport the idea to 4.14 to spread the interrupts around on 
allocation.

Thanks
Josh







