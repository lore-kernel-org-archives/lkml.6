Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D082145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7dUVLws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D082145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbeKPQN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:13:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeKPQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:13:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAG5xpMa071951;
        Fri, 16 Nov 2018 06:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id :
 mime-version : date : from : to : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=wGxsFQhwCabygpVAsQSsEpG5M+YOgawDstT+hd9aY9Y=;
 b=Q7dUVLwsTPEQk93U65Eds3ZBk8Ssbedxu5hL897lpeoEDqAcJByfN1wtpwVNalFcG5hq
 yK99RBk5wth+l1Kv565POwGDj0ecuODTYI80bw5VrbhvAMxl+rltADnfj3G+D4O5QNvK
 e5RJ5FwH6Pg2mjnIx9rkcPn41zl97Z23vhzteev+I9jhkBZF/nHz1z6A0QiHWghkZYjm
 FOb2N7QbukjFTjEIePZCLOGHkofo5sdz7Mq99BD7eJ1uUiccLGSEKScwLpH0FPqBSiaB
 bbHTqGDv7/LeWHyi1vbN2OhNkzmrkKBuf+mtp8OLYKQpiNbUqx56JAYt9Y7obyPEpJ5i 9Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nr7csdd4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 06:02:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAG62uug019379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 06:02:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAG62uAu005007;
        Fri, 16 Nov 2018 06:02:56 GMT
Message-Id: <201811160602.wAG62uAu005007@aserv0121.oracle.com>
Received: from localhost (/10.159.211.98) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Thu, 15 Nov 2018 22:02:56 -0800
MIME-Version: 1.0
Date:   Thu, 15 Nov 2018 22:02:56 -0800 (PST)
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC] DTrace based on eBPF and other tracing facilities
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9078 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of work has been done on various aspects of the tracing infrastructure
in Linux in the past years and with the further development of BPF a quite
powerful execution engine has become available as well.

One of the difficulties we have experienced in furthering DTrace on Linux is
that we have to duplicate functionality already available in the kernel
because that functionality is not easy to make use of.

In the past year or so we have been working towards changing that.  There is
no point in having multiple projects reinvent the same wheel a couple of times
over, especially when there are ways where everyone can benefit from actually
cooperating.  Our current (lofty) goal is to rework the DTrace implementation 
that we currently have to make it more modular and less self-sufficient.  We
are envisioning a future for DTrace where we can leverage its strengths in the
areas where it matters most (e.g. very efficient handling of large amounts of
kernel probes, well defined and understood D language, user familiarity with
existing providers, ...) while building on the existing tracing infrastructure
in Linux.  That also means that we can contribute better to existing pieces
in the infrastructure and work together with other tracing projects to continue
to improve tracing on Linux.

Ideally we would like to see an infrastructure where any tracers can attach
actions to any kind of probe source, and have data generated according to the
actions the tracer associated with the probe source when a specific probe
fires.  The execution of those actions would be done using BPF.

We believe that this proposal would be a benefit to all because it allows us
to pool resources in the areas that really need it.  E.g. if we all depend on
BPF as execution engine we invariably work together to make it as solid as can
be.

Obviously we cannot do this work on our own, and we cannot do it behind closed
doors.  We've created a github repository for the kernel with DTrace added in
at:

  https://github.com/ezannoni/dtrace-linux-kernel/tree/master

We also have a branch there with the most recent BPF-based work:

  https://github.com/ezannoni/dtrace-linux-kernel/tree/nix/bpf/4.19/helpers

Since most (if not all) tracing tools have similar requirements for what may
need to be done when a probe fires, we really want to join forces.

	Cheers,
	Kris
