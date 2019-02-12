Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4855C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B3C217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dPwog4Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfBLQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:13 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:55606 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729078AbfBLQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549990211;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=d9wM12jhuDTWdWt+Pkovf6I5uVUhrDCPMcwRg2iB6/c=;
        b=dPwog4Db8cxWFTs8RaPbWPHsdjVXXzK6xqpC2es8j1a9vMwSTJTBbxIqClS4bTWi
        jn3E5648vwwyFuDLlzLP3ebtNmQ8QHcaanGSqOxZWOF9WwuscWPvVRcezYZjIzwFHH3
        zSJ0zA/tay7p90Jbs8Pdv9fCw9l9ZFY8VqBAPqsw=
Date:   Tue, 12 Feb 2019 16:50:11 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, jgg@ziepe.ca,
        akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hao.wu@intel.com, atull@kernel.org, mdf@kernel.org
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm
 to account pinned pages
In-Reply-To: <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
Message-ID: <01000168e29daf0a-cb3a9394-e3dd-4d88-ad3c-31df1f9ec052-000000@email.amazonses.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com> <20190211224437.25267-3-daniel.m.jordan@oracle.com> <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.12-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Alexey Kardashevskiy wrote:

> Now it is 3 independent accesses (actually 4 but the last one is
> diagnostic) with no locking around them. Why do not we need a lock
> anymore precisely? Thanks,

Updating a regular counter is racy and requires a lock. It was converted
to be an atomic which can be incremented without a race.
