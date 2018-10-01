Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D6E20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D6E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeJBDHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:07:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbeJBDHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:07:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2BEBAEE9;
        Mon,  1 Oct 2018 20:27:26 +0000 (UTC)
Date:   Mon, 1 Oct 2018 22:27:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Juliet Kim <minkim@us.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
Message-ID: <20181001202724.GL18290@dhcp22.suse.cz>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-10-18 13:56:25, Michael Bringmann wrote:
> In some LPAR migration scenarios, device-tree modifications are
> made to the affinity of the memory in the system.  For instance,
> it may occur that memory is installed to nodes 0,3 on a source
> system, and to nodes 0,2 on a target system.  Node 2 may not
> have been initialized/allocated on the target system.
> 
> After migration, if a RTAS PRRN memory remove is made to a
> memory block that was in node 3 on the source system, then
> try_offline_node tries to remove it from node 2 on the target.
> The NODE_DATA(2) block would not be initialized on the target,
> and there is no validation check in the current code to prevent
> the use of a NULL pointer.

I am not familiar with ppc and the above doesn't really help me
much. Sorry about that. But from the above it is not clear to me whether
it is the caller which does something unexpected or the hotplug code
being not robust enough. From your changelog I would suggest the later
but why don't we see the same problem for other archs? Is this a problem
of unrolling a partial failure?

dlpar_remove_lmb does the following

	nid = memory_add_physaddr_to_nid(lmb->base_addr);

	remove_memory(nid, lmb->base_addr, block_sz);

	/* Update memory regions for memory remove */
	memblock_remove(lmb->base_addr, block_sz);

	dlpar_remove_device_tree_lmb(lmb);

Is the whole operation correct when remove_memory simply backs off
silently. Why don't we have to care about memblock resp
dlpar_remove_device_tree_lmb parts? In other words how come the physical
memory range is valid while the node association is not?
-- 
Michal Hocko
SUSE Labs
