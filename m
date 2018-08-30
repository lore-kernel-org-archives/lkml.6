Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A753C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A553E2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VZnQofHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A553E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeH3PVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:21:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeH3PVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:21:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UBJumf152517;
        Thu, 30 Aug 2018 11:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=els9/U7elVtxbL59g8TfMaurLBM9UZhUOAmVtNRf+0U=;
 b=VZnQofHRRfXkxsyhTnQbBgbTVpWFiejvV42QvjTmPL+8W0ndR0WBrk8PqaKDFN+Yft79
 TS7f+5Y+sZ88LMKaR2R4aYECsltIDvYb0XAk3113peozdRfwaATIVxz7kFPTt5iFOI3l
 Y+uq3yIMD7/HMocQtxHputBMr+oFtZq4E5JYZXDTvvFIfi8d5Jy0ebVLk5lvnqlbXtTS
 Vs4/ujXtnBUt3I6QIShh+8rP0I26+ElBoYr+lgR0OFACDIIyOyFxealABBRVkRsL0L5L
 Hs6B7yHBzFKayqqaEMkLaaEfusasHyoDUADNx9m+gfSX7tINQPlXAMzcqTA6wJozr6YX QA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xhu0ya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:19:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBJFmb029278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:19:15 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBJEie027971;
        Thu, 30 Aug 2018 11:19:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 04:19:14 -0700
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] iscsi-target: Don't use stack buffer for scatterlist
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180823203626.15108-1-labbott@redhat.com>
Date:   Thu, 30 Aug 2018 07:19:10 -0400
In-Reply-To: <20180823203626.15108-1-labbott@redhat.com> (Laura Abbott's
        message of "Thu, 23 Aug 2018 13:36:26 -0700")
Message-ID: <yq18t4o5cgh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Fedora got a bug report of a crash with iSCSI:
>
> kernel BUG at include/linux/scatterlist.h:143!
> ...
> RIP: 0010:iscsit_do_crypto_hash_buf+0x154/0x180 [iscsi_target_mod]
> ...
>  Call Trace:
>   ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
>   iscsit_get_rx_pdu+0x4cd/0xa90 [iscsi_target_mod]
>   ? native_sched_clock+0x3e/0xa0
>   ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
>   iscsi_target_rx_thread+0x81/0xf0 [iscsi_target_mod]
>   kthread+0x120/0x140
>   ? kthread_create_worker_on_cpu+0x70/0x70
>   ret_from_fork+0x3a/0x50
>
> This is a BUG_ON for using a stack buffer with a scatterlist.  There
> are two cases that trigger this bug. Switch to using a dynamically
> allocated buffer for one case and do not assign a NULL buffer in
> another case.

Mike: Please review. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
