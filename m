Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F21C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2630620843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dTtrUjDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2630620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeIZHP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:15:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIZHP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:15:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q14Qem042215;
        Wed, 26 Sep 2018 01:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CWI+D9ZLY+qH/kuAO2+nX8wd9G1Xw2Io3um85O7G4p8=;
 b=dTtrUjDBuWUFlV2Xlmt9My1/+YDBDVmCMeY+P0jnCBDUNVTHSl/QUcx6zh3hluqYJDhI
 OcM4MbCgfrsvCW/5crUoZHn8QCDqmNs5r7kS42lt/m58nzZOnBdFP2xoXc3NaWg2t90Z
 31pfxlbwqCY09z/RhYrV2UQKaUbo9pBlkoAHS3itP2kelyuMpS0kZ+pBXTCFuezazNl4
 LdOO6EaG16UXAhVacBWbRQ9uplWth2pppYIibWmJD980Zy+TLWA3LYDiVbQ0Pc9ryF98
 iiispHF0tFO6hZSSRhcIpy3gbjr5vNWPQzlA578NxKNAMigpFAkrD37yuPic9YLi90UC ZQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mnd5tfgmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 01:05:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q158XG002352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 01:05:08 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8Q158xh028843;
        Wed, 26 Sep 2018 01:05:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 18:05:07 -0700
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.vnet.ibm.com, evgreen@chromium.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subhash Jadavani <subhashj@codeaurora.org>, mka@chromium.org
Subject: Re: [PATCH 1/1] scsi/ufshcd: Fix NULL pointer dereference for in ufshcd_init
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
        <CAE=gft5ONyVQ6qkP41G_vx-Djo0MqHhXZ6pjTOZjTDpPgwukZQ@mail.gmail.com>
        <CAFp+6iEpZThehq4896dmYifvbNF5wa3ESyw7yBv7vpUbtQKzhA@mail.gmail.com>
        <CAFp+6iFVQKvWj7o+nmoJVhgQpOz2gZ_Eo+e8c8qdoc18waJ+zw@mail.gmail.com>
Date:   Tue, 25 Sep 2018 21:05:03 -0400
In-Reply-To: <CAFp+6iFVQKvWj7o+nmoJVhgQpOz2gZ_Eo+e8c8qdoc18waJ+zw@mail.gmail.com>
        (Vivek Gautam's message of "Tue, 25 Sep 2018 15:20:43 +0530")
Message-ID: <yq1lg7pgjb4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Vivek,

>> > > Bjorn, Subhash,
>> > > I am not certain of some of these devfreq, and clk_scaling bits
>> > > that are moved as part of this patch. Please help in reviewing the
>> > > change in the light of these features, and related sequence should
>> > > be followed.
>> > > Thanks.
>> > >
>> >
>> > You're right, there is a lot of logic moving around here. I think this
>> > looks okay to me.
>> >
>> > Reviewed-by: Evan Green <evgreen@chromium.org>
>>
>> Thanks Evan.
>>
>> Best regards
>> Vivek
>
> Gentle ping. Will you please consider picking this patch for the
> merge?

I was waiting for some feedback from Bjorn or Subhash.

-- 
Martin K. Petersen	Oracle Linux Engineering
