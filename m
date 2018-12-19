Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97733C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBw/4LCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeLSUrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:47:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeLSUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:47:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBJKhp1V015074;
        Wed, 19 Dec 2018 20:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=9l2GylBQDjrn6bBLTaSkrgGaZi0gvPQCHJEi3xgymY4=;
 b=kBw/4LCPHLr3Zyz+6X7j92/a3O70v6PNobFC81b0xHK39iV241QcH5CL30zTjUDre6p2
 hZ1xvs4PIaspEEHKWRIrc9bq3QZxIRHLLnTi5GZrqmfLDLpK9DL6VLDPDNJYUTGiK1ur
 iHgQbxZGwE1y7ZGCydkIJRB/zCu2LpeI7CGd636RKGrHg/bDa8/XwWVXv5jg3dytlIto
 NBRPA4vCNyai1pO9jxuLvrZDP46qUCOhVjTPYUV8xZDiw3LfcNDxBwLrbsE/W/WYEvW7
 oML4zU5R+kWlSNIhi0NxUl7o1YOq6BiSkXN3mGjk6r2rONDYgHmbvJC1T5NNPvuAPy6s ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pf8gfdm6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 20:46:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBJKkNm5032614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 20:46:23 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBJKkMt4016484;
        Wed, 19 Dec 2018 20:46:22 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 12:46:22 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
Date:   Wed, 19 Dec 2018 13:46:15 -0700
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <114881A8-8960-4436-AAE4-DE40BFFCFB4B@oracle.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=797
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812190162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 18, 2018, at 11:53 AM, Vineet Gupta =
<Vineet.Gupta1@synopsys.com> wrote:
>=20
> Use on-stack smaller buffers instead of dynamic pages.
>=20
> The motivation for this change was to address lockdep splat when
> signal handling code calls show_regs (with preemption disabled) and
> ARC show_regs calls into sleepable page allocator.
>=20
> | potentially unexpected fatal signal 11.
> | BUG: sleeping function called from invalid context at =
../mm/page_alloc.c:4317
> | in_atomic(): 1, irqs_disabled(): 0, pid: 57, name: segv
> | no locks held by segv/57.
> | Preemption disabled at:
> | [<8182f17e>] get_signal+0x4a6/0x7c4
> | CPU: 0 PID: 57 Comm: segv Not tainted 4.17.0+ #23
> |
> | Stack Trace:
> |  arc_unwind_core.constprop.1+0xd0/0xf4
> |  __might_sleep+0x1f6/0x234
> |  __get_free_pages+0x174/0xca0
> |  show_regs+0x22/0x330
> |  get_signal+0x4ac/0x7c4     # print_fatal_signals() -> =
preempt_disable()
> |  do_signal+0x30/0x224
> |  resume_user_mode_begin+0x90/0xd8
>=20
> Despite this, lockdep still barfs (see next change), but this patch
> still has merit as in we use smaller/localized buffers now and there's
> less instructoh trace to sift thru when debugging pesky issues.
>=20
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

I would rather see 256 as a #define somewhere rather than a magic number =
sprinkled
around arch/arc/kernel/troubleshoot.c.

Still, that's what the existing code does, so I suppose it's OK.

Otherwise the change looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

