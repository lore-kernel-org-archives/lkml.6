Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBIKGQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:06:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:47387 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeBIKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:06:14 -0500
Date: Fri, 9 Feb 2018 11:06:11 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] livepatch: Initial support for dynamic
 structures
In-Reply-To: <20180206103424.10829-4-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802081643010.18225@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com> <20180206103424.10829-4-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> For this, we will need to dynamically create funcs and objects
> for functions that are not longer patched.
> 
> This patch adds basic framework to handle such dynamic structures.
> 
> It adds enum klp_func_type that allows to distinguish the dynamically
> allocated funcs' structures. Note that objects' structures do not have
> a clear type. Namely the static objects' structures might list both static
> and dynamic funcs' structures.
> 
> The function type is then used to limit klp_free() functions. We will
> want to free the dynamic structures separately when they are not
> longer needed. At the same time, we also want to make our life easier,
> and introduce _any_ type that will allow to process all existing
> structures in one go.
> 
> We need to be careful here. First, objects' structures must be freed
> only when all listed funcs' structures are freed. Also we must avoid
> double free. Both problems are solved by removing the freed structures
> from the list.
> 
> Also note that klp_free*() functions are called also in klp_init_patch()
> error path when only some kobjects have been initialized. The other
> dynamic structures must be freed immediately by calling the respective
> klp_free_*_dynamic() functions.
> 
> Finally, the dynamic objects' structures are generic. The respective
> klp_allocate_object_dynamic() and klp_free_object_dynamic() can
> be implemented here. On the other hand, klp_free_func_dynamic()
> is empty. It must be updated when a particular dynamic
> klp_func_type is introduced.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Converted into a generic API]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>

This patch introduces klp_get_or_add_object(), but it is not used here. 
One of the later patches adds its call site. GCC warns about this. I like 
it being introduced here, because it belongs to the patch. Someone may 
complain though.

Also klp_free_objects() is not declared as static and sparse complains 
about it. Petr, you can make it static here and drop the keyword later.

Otherwise it looks good.

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
