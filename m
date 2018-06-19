Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A079C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBEC20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tCN0XiQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBEC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937212AbeFSC07 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:26:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937113AbeFSC05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:26:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J2J5ZQ154062;
        Tue, 19 Jun 2018 02:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=DBZccI+ULTCpyb81+VQmg7VuZsAITPhAQw5AyyArqAI=;
 b=tCN0XiQdfxHWTzq51+OuUkPHKBp8R+CcnwMmnP3IztG0kP4f+Jfg/HBGIfiFWBXfx3dD
 2w5/NTe80KeUcTcsFffyUsAe2fffRb8yoW7No/JC/44nYyYzbSmHRTA4VFh7CJHqwcGa
 16JlLkYW7uCnfGCC5ICKeP4+3bhVpFMbpF3nV7NdiNwnAkiG1MHP/p4+lRjfLL7SyF2L
 U98LVt+GUo/Rwo+a5MoWSWlZzsqv5W+c2jws5VobqVFLYl124DeMQGsfMg6Q72wbORmp
 mu59u0yqS1M7h3f2LbMNa6dhSLk7lWTl6zLp4HaLRoTZvSHWN8nWN0ZJaklmUtQx9FzO lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2med55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:26:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J2QIIm013786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:26:18 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5J2QGOt011414;
        Tue, 19 Jun 2018 02:26:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 19:26:16 -0700
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180612190545.10781-1-willy@infradead.org>
        <yq136xols59.fsf@oracle.com>
        <20180615023731.GA5706@bombadil.infradead.org>
Date:   Mon, 18 Jun 2018 22:26:13 -0400
In-Reply-To: <20180615023731.GA5706@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 14 Jun 2018 19:37:31 -0700")
Message-ID: <yq1bmc7ikai.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=9 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=9 mlxscore=9 mlxlogscore=101
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

>> Since most of the changes are in scsi or target, should I take this
>> series through my tree?
>
> I'd welcome that.  Nick seems to be inactive as target maintainer;
> his tree on kernel.org hasn't seen any updates in five months.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
