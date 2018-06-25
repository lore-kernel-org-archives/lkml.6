Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BE726072
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE726072
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeFYTaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:30:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933030AbeFYTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:30:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PJDYbV069877
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:30:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju4xdv6y6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:30:21 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 15:30:19 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 15:30:16 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PJUFj67078254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 19:30:15 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9003112063;
        Mon, 25 Jun 2018 15:30:10 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61A6D112066;
        Mon, 25 Jun 2018 15:30:09 -0400 (EDT)
Received: from oc6857751186.ibm.com (unknown [9.85.170.106])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 15:30:09 -0400 (EDT)
Subject: Re: [PATCH] scsi_transport_fc: use 64-bit timestamps consistently
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180618153004.1808419-1-arnd@arndb.de>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Mon, 25 Jun 2018 12:30:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618153004.1808419-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18062519-0068-0000-0000-0000030E0170
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009254; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052235; UDB=6.00539409; IPR=6.00830161;
 MB=3.00021851; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 19:30:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062519-0069-0000-0000-000044CE7CF7
Message-Id: <3161ed3e-1237-6e80-2f3a-79cb8179a417@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 08:29 AM, Arnd Bergmann wrote:
> The get_seconds() helper returns an 'unsigned long' value, which can
> overflow on 32-bit architectures. Since the interface we pass it into
> already uses a 64-bit type, we can just use ktime_get_real_seconds()
> instead.
> 
> While we generally prefer local timestamps in CLOCK_MONOTONIC format
> (ktime_get_seconds), this keeps using the CLOCK_REALTIME version
> in order to maintain compatibility with existing code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

