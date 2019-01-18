Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FAC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4A920883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfARRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:45:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbfARRpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:45:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36296578;
        Fri, 18 Jan 2019 17:45:17 +0000 (UTC)
Received: from redhat.com (ovpn-123-236.rdu2.redhat.com [10.10.123.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C3A0104811E;
        Fri, 18 Jan 2019 17:45:15 +0000 (UTC)
Date:   Fri, 18 Jan 2019 12:45:13 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [LSF/MM TOPIC] NUMA, memory hierarchy and device memory
Message-ID: <20190118174512.GA3060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 18 Jan 2019 17:45:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i would like to discuss about NUMA API and its short comings when
it comes to memory hierarchy (from fast HBM, to slower persistent
memory through regular memory) and also device memory (which can have
its own hierarchy).

I have proposed a patch to add a new memory topology model to the
kernel for application to be able to get that informations, it
also included a set of new API to bind/migrate process range [1].
Note that this model also support device memory.

So far device memory support is achieve through device specific ioctl
and this forbid some scenario like device memory interleaving accross
multiple devices for a range. It also make the whole userspace more
complex as program have to mix and match multiple device specific API
on top of NUMA API.

While memory hierarchy can be more or less expose through the existing
NUMA API by creating node for non-regular memory [2], i do not see this
as a satisfying solution. Moreover such scheme does not work for device
memory that might not even be accessible by CPUs.


Hence i would like to discuss few points:
    - What proof people wants to see this as problem we need to solve ?
    - How to build concensus to move forward on this ?
    - What kind of syscall API people would like to see ?

People to discuss this topic:
    Dan Williams <dan.j.williams@intel.com>
    Dave Hansen <dave.hansen@intel.com>
    Felix Kuehling <Felix.Kuehling@amd.com>
    John Hubbard <jhubbard@nvidia.com>
    Jonathan Cameron <jonathan.cameron@huawei.com>
    Keith Busch <keith.busch@intel.com>
    Mel Gorman <mgorman@techsingularity.net>
    Michal Hocko <mhocko@kernel.org>
    Paul Blinzer <Paul.Blinzer@amd.com>

Probably others, sorry if i miss anyone from previous discussions.

Cheers,
Jérôme

[1] https://lkml.org/lkml/2018/12/3/1072
[2] https://lkml.org/lkml/2018/12/10/1112
