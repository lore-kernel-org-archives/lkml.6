Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB1C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCHRM5PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJPMP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:15:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeJPMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G49EbH094327;
        Tue, 16 Oct 2018 04:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MLeZdhYWvwa+XKVCAcyadKUhzQZ0WUm2Lo1gD5LfELU=;
 b=CCHRM5PQcmsgcFC8IqG13YVM4/1IJVLc0SvdpQwUV41oSohY3VtR6I0H9bdD6B76NReU
 SbWQMB75h9ccLGPqdoEOz2+cCn28BHTGrt3i83xj3semtsV6gglUqq5swabp76+Df/Q6
 biGRK4GNUfwBJypGTFbbIUEKtEhHhjsiikQuLvpqU+/5ABh26h9CdAE0KnD/fH6eAEW9
 4mui3K5tfSxEOiU4e7Fvbc68Ix2xgscIj6328/k/MUJTIRieXLi7CxdiF5AnxvjTfd5I
 rsv4j2M6k5Vl1lzDoV2UnRoqzaOKF2ezF0hH9ixy3Z5fUkjOw5IOCuhAQgb+0S/6LWp0 Pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38npx0xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 04:13:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9G4Dg3M029558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 04:13:43 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G4Df8s010162;
        Tue, 16 Oct 2018 04:13:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 21:13:41 -0700
To:     "Ly\, Bryant" <bly@catalogicsoftware.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with active signals
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
        <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
        <5BBE2FBF.7080804@redhat.com>
        <1539237365.6150.32.camel@haakon3.daterainc.com>
        <F43269BA-4D7B-486C-87C6-0FB48FF890EA@catalogicsoftware.com>
Date:   Tue, 16 Oct 2018 00:13:38 -0400
In-Reply-To: <F43269BA-4D7B-486C-87C6-0FB48FF890EA@catalogicsoftware.com>
        (Bryant Ly's message of "Thu, 11 Oct 2018 13:05:59 +0000")
Message-ID: <yq1lg6yv899.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bryant,

> VMs do not remove the I_T nexus while the VM is active, so we can remove
> the target_wait_for_sess_cmd() call. 

Patch forthcoming?

-- 
Martin K. Petersen	Oracle Linux Engineering
