Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6619FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF221654
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ji9wp3Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAF221654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeHOLV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:21:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeHOLV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:21:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F8TnTe031784;
        Wed, 15 Aug 2018 08:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F163zw67rpznu8qFKGkGx2SpO2MyfzSHwuSHHpx7hys=;
 b=Ji9wp3Cb/NFEgaccoX0UmIROahgLTndHjlHUR+JAsVudja+EuPjgSKh4bDKPskHghQBY
 GJOEZz0ogE02JaoO/3yr4zfqODj7dIXfXxK0fMGRO+DQ1TzHQr4fNuWaW2uLQV8ysmCO
 xtPBps24nMyLuYxZ7l6QvoL8IoJ14KoiX3loio8B6TafOJHy1obGZUWLGYQtSQpQes7H
 dNOAQ18nmjCkXXLDcynv9XGDLdTEZa9YTlOjhBBDZIpdpzA8QKWn4rBmPvAr0Be7dvFg
 gbc3Z0/sD85kaa1/CzMXXTwpaTLrnaCRIrDDd4A5ZUSyYcwrdGFweGVUiXRz1cMVMxum Uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ksqrpbjc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 08:30:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7F8U7g0020719
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 08:30:07 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7F8U6ao029693;
        Wed, 15 Aug 2018 08:30:06 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Aug 2018 01:30:05 -0700
Date:   Wed, 15 Aug 2018 11:29:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
Message-ID: <20180815082956.u6grueiyshwgqt3a@mwanda>
References: <20180813223910.26276-1-surenb@google.com>
 <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
 <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
 <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
 <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
 <CAJuCfpEX+F-EPxQYXNdUg-uT9ecwYYdxBsr9y_69zQ0Fq50GeA@mail.gmail.com>
 <CAJuCfpGSPkB-tk4GHaJeStRph-ibVhUZ119Sfd16xgf9x=qUwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGSPkB-tk4GHaJeStRph-ibVhUZ119Sfd16xgf9x=qUwQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=658
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 03:38:14PM -0700, Suren Baghdasaryan wrote:
> The separate fix for the size of pipes[] array is posted here:
> https://lkml.org/lkml/2018/8/14/1034
> Thanks!
> 

That's great!  Let's add some bounds checking to nfc_hci_msg_rx_work()
and nfc_hci_recv_from_llc() as well and then we can close the chapter on
these bugs.

regards,
dan carpenter

