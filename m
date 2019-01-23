Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDFAC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77459217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5ZbZEJud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfAWB5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:57:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50186 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfAWB5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:57:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N1s5cN076187;
        Wed, 23 Jan 2019 01:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jHt/eNVjdoyvTfXrCFxLx2e/kNNFgyGTC8EcSH/9hO4=;
 b=5ZbZEJud7LP6RZ0YUf2n6+6jkxXh0cqI9iRDqEHKao1NcKZKnhG5WzD35NMPGwucobCZ
 B3Jv3qXFnY75gLJREx21csgIEDHBptkfMSpQUeebfmASJ54pJ2Ycu2J+F96ygSnyUIiD
 AsKOefrlHnSYbQCBDD/nEB9IPZ2skm2mMrtrl/0UdvtjNQffn5Sz9ZC/G/EZbHHj35/b
 aDi7oOvMe8MrC64LX/V287edQs13yjvXX6k9jVpv6M1dgCtob0nEg0J6X6iQrtzHp8wh
 eVwwh9XmFNtx4/7DybREQarSBGkicIK09w0wWWUteJ80EiUbUlEz7Wr+KdUqaLHU4HxD 5A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdef9fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 01:56:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0N1unUK006909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 01:56:49 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0N1um8H000464;
        Wed, 23 Jan 2019 01:56:48 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 17:56:48 -0800
Subject: Re: [LSF/MM TOPIC] Page flags, can we free up space ?
To:     Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20190122201744.GA3939@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6e4a377d-8f06-7b2c-4be7-23da72ccb18e@oracle.com>
Date:   Tue, 22 Jan 2019 17:56:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122201744.GA3939@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 12:17 PM, Jerome Glisse wrote:
> So lattely i have been looking at page flags and we are using 6 flags
> for memory reclaim and compaction:
> 
>     PG_referenced
>     PG_lru
>     PG_active
>     PG_workingset
>     PG_reclaim
>     PG_unevictable
> 
> On top of which you can add the page anonymous flag (anonymous or
> share memory)
>     PG_anon // does not exist, lower bit of page->mapping
> 
> And also the movable flag (which alias with KSM)
>     PG_movable // does not exist, lower bit of page->mapping
> 
> 
> So i would like to explore if there is a way to express the same amount
> of information with less bits. My methodology is to exhaustively list
> all the possible states (valid combination of above flags) and then to
> see how we change from one state to another (what event trigger the change
> like mlock(), page being referenced, ...) and under which rules (ie do we
> hold the page lock, zone lock, ...).
> 
> My hope is that there might be someway to use less bits to express the
> same thing. I am doing this because for my work on generic page write
> protection (ie KSM for file back page) which i talk about last year and
> want to talk about again ;) I will need to unalias the movable bit from
> KSM bit.
> 
> 
> Right now this is more a temptative ie i do not know if i will succeed,
> in any case i can report on failure or success and discuss my finding to
> get people opinions on the matter.
> 
> 
> I think everyone interested in mm will be interested in this topic :)

Explicitly adding Matthew on Cc as I am pretty sure he has been working
in this area.

-- 
Mike Kravetz
