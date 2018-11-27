Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA52208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA52208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeK1Bey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:34:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbeK1Bey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:34:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAREY5lL103286
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:36:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p16r9ka37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:36:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 27 Nov 2018 14:36:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 14:36:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAREae2C5636430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 14:36:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7565811C04A;
        Tue, 27 Nov 2018 14:36:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DF4211C04C;
        Tue, 27 Nov 2018 14:36:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Nov 2018 14:36:40 +0000 (GMT)
Date:   Tue, 27 Nov 2018 15:36:38 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
 <20181127131916.GX12455@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20181127131916.GX12455@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 18112714-4275-0000-0000-000002E77989
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112714-4276-0000-0000-000037F4B6CC
Message-Id: <20181127143638.GE3625@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:19:16PM +0100, Michal Hocko wrote:
> On Tue 27-11-18 09:36:03, Heiko Carstens wrote:
> > Use pr_alert_once() instead of pr_alert() if page table misaccounting
> > has been detected.
> > 
> > If this happens once it is very likely that there will be numerous
> > other occurrence as well, which would flood dmesg and the console with
> > hardly any added information. Therefore print the warning only once.
> 
> Have you actually experience a flood of these messages? Is one per mm
> message really that much?

Yes, I did. Since in this case all compat processes caused the message
to appear, I saw thousands of these messages.

> If yes why rss counters do not exhibit the same problem?

No rss counter messages appeared. Or do you suggest that the other
pr_alert() within check_mm() should also be changed?

