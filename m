Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0FEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8211F20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8211F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeGYVpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:45:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbeGYVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:45:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PKNtTh041394
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:31:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2key1bjgfq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:31:45 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 25 Jul 2018 16:31:43 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 16:31:39 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PKVdZF8061322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 20:31:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D258AC059;
        Wed, 25 Jul 2018 16:32:22 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3F57AC05E;
        Wed, 25 Jul 2018 16:32:21 -0400 (EDT)
Received: from localhost (unknown [9.85.190.157])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 16:32:21 -0400 (EDT)
Date:   Wed, 25 Jul 2018 17:31:35 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] powerpc/traps: Return early in show_signal_msg()
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-3-muriloo@linux.ibm.com>
 <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18072520-0052-0000-0000-00000313706B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009426; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066073; UDB=6.00547681; IPR=6.00843932;
 MB=3.00022324; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 20:31:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072520-0053-0000-0000-00005D7D84AF
Message-Id: <20180725203135.GD23643@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Wed, Jul 25, 2018 at 05:42:28PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Modify logic of show_signal_msg() to return early, if possible.  Replace
> > printk_ratelimited() by printk() and a default rate limit burst to limit
> > displaying unhandled signals messages.
> 
> Can you explain more the benefits of this change ?

Mainly is to improve readability of the function.

The conditions to display the message were coupled together in one
single `if` statement.

Besides that, patch 5/7 adds a call to print_vma_addr(), which is not
aware of any rate limit - it simply calls printk().

So splitting out the rate limit check outside show_signal_msg() makes it
easier to the caller decide if it wants to respect a printk rate limit
or not.

Cheers
Murilo

