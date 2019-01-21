Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C387C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BF320870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfAUWeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbfAUWea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:34:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22CFB3695F;
        Mon, 21 Jan 2019 22:34:30 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AF2E1019633;
        Mon, 21 Jan 2019 22:34:29 +0000 (UTC)
Date:   Mon, 21 Jan 2019 17:34:27 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] livepatch: Introduce klp_for_each_patch macro
Message-ID: <20190121223427.GA8766@redhat.com>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161720.796-2-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 21 Jan 2019 22:34:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:17:17PM +0100, Petr Mladek wrote:
> There are already macros to iterate over struct klp_func and klp_object.
> 
> Add also klp_for_each_patch(). But make it internal because also
> klp_patches list is internal.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/livepatch/core.c       | 8 ++++----
>  kernel/livepatch/core.h       | 6 ++++++
>  kernel/livepatch/transition.c | 2 +-
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index adca5cf07f7e..b716a6289204 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -554,7 +554,7 @@ static int klp_add_nops(struct klp_patch *patch)
>  	struct klp_patch *old_patch;
>  	struct klp_object *old_obj;
>  
> -	list_for_each_entry(old_patch, &klp_patches, list) {
> +	klp_for_each_patch(old_patch) {
>  		klp_for_each_object(old_patch, old_obj) {
>  			int err;
>  
> @@ -1089,7 +1089,7 @@ void klp_discard_replaced_patches(struct klp_patch *new_patch)
>  {
>  	struct klp_patch *old_patch, *tmp_patch;
>  
> -	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
> +	klp_for_each_patch_safe(old_patch, tmp_patch) {
>  		if (old_patch == new_patch)
>  			return;
>  
> @@ -1133,7 +1133,7 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
>  	struct klp_patch *patch;
>  	struct klp_object *obj;
>  
> -	list_for_each_entry(patch, &klp_patches, list) {
> +	klp_for_each_patch(patch) {
>  		if (patch == limit)
>  			break;
>  
> @@ -1180,7 +1180,7 @@ int klp_module_coming(struct module *mod)
>  	 */
>  	mod->klp_alive = true;
>  
> -	list_for_each_entry(patch, &klp_patches, list) {
> +	klp_for_each_patch(patch) {
>  		klp_for_each_object(patch, obj) {
>  			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
>  				continue;
> diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
> index e6200f38701f..ec43a40b853f 100644
> --- a/kernel/livepatch/core.h
> +++ b/kernel/livepatch/core.h
> @@ -7,6 +7,12 @@
>  extern struct mutex klp_mutex;
>  extern struct list_head klp_patches;
>  
> +#define klp_for_each_patch_safe(patch, tmp_patch)		\
> +	list_for_each_entry_safe(patch, tmp_patch, &klp_patches, list)
> +
> +#define klp_for_each_patch(patch)	\
> +	list_for_each_entry(patch, &klp_patches, list)
> +
>  void klp_free_patch_start(struct klp_patch *patch);
>  void klp_discard_replaced_patches(struct klp_patch *new_patch);
>  void klp_discard_nops(struct klp_patch *new_patch);
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 300273819674..a3a6f32c6fd0 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -642,6 +642,6 @@ void klp_force_transition(void)
>  	for_each_possible_cpu(cpu)
>  		klp_update_patch_state(idle_task(cpu));
>  
> -	list_for_each_entry(patch, &klp_patches, list)
> +	klp_for_each_patch(patch)
>  		patch->forced = true;
>  }
> -- 
> 2.13.7
> 

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
