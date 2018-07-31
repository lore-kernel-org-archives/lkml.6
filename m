Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33646C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFC320840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFC320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeGaFzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:55:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60806 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeGaFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:55:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fkM5S-00015w-Ou; Tue, 31 Jul 2018 04:16:42 +0000
Date:   Tue, 31 Jul 2018 05:16:42 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
Message-ID: <20180731041642.GH30522@ZenIV.linux.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 06:35:10PM +0100, David Howells wrote:
> params->request indicates the attribute/attributes to be queried.  This can
> be one of:
> 
> 	fsinfo_attr_statfs		- statfs-style info
> 	fsinfo_attr_fsinfo		- Information about fsinfo()
> 	fsinfo_attr_ids			- Filesystem IDs
> 	fsinfo_attr_limits		- Filesystem limits
> 	fsinfo_attr_supports		- What's supported in statx(), IOC flags
> 	fsinfo_attr_capabilities	- Filesystem capabilities
> 	fsinfo_attr_timestamp_info	- Inode timestamp info
> 	fsinfo_attr_volume_id		- Volume ID (string)
> 	fsinfo_attr_volume_uuid		- Volume UUID
> 	fsinfo_attr_volume_name		- Volume name (string)
> 	fsinfo_attr_cell_name		- Cell name (string)
> 	fsinfo_attr_domain_name		- Domain name (string)
> 	fsinfo_attr_realm_name		- Realm name (string)
> 	fsinfo_attr_server_name		- Name of the Nth server (string)
> 	fsinfo_attr_server_address	- Mth address of the Nth server
> 	fsinfo_attr_parameter		- Nth mount parameter (string)
> 	fsinfo_attr_source		- Nth mount source name (string)
> 	fsinfo_attr_name_encoding	- Filename encoding (string)
> 	fsinfo_attr_name_codepage	- Filename codepage (string)
> 	fsinfo_attr_io_size		- I/O size hints

Umm...  What's so special about cell/volume/domain/realm?  And
what do we do when a random filesystem gets added - should its
parameters go into catch-all pile (attr_parameter), or should they
get classes of their own?

For Cthulhu sake, who's going to maintain that enum in face of
random out-of-tree filesystems, each wanting a class or two its own?
We'd tried that with device numbers; ask hpa how well has that
worked and how much did he love the whole experience...
