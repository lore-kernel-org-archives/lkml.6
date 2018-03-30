Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4+hm7uzVGDD9KGyMPZBPpsvdtC8AvWiOg7jhwkKVY/6C4XCUFI/fBFnPw6NKcC+W6EWNCiR
ARC-Seal: i=1; a=rsa-sha256; t=1522436319; cv=none;
        d=google.com; s=arc-20160816;
        b=VoUdbz42yjzhqrZcAValgavkeuDKyV9tUb3ePkaMHgsDoqKjqLJyr9NSPdtsC5nm5Y
         0V+hZseK/nyEcxAyjhuAsxf/62jSj4qNhjE6mFVrRA6/do2hSQBAFzQIyAssTQAR08kn
         Np8Vyo/E30JlmQ3NlX17gf0HEsJNABJDKz5mK1fqlhbGrfx4L1bOWRbbolgMcXAMPYJJ
         oVekeGEm61YSGgQBSRMiGJITjjzmSvbtDz6rsLYE3nsWnLSb2FaX8ZgfV73wMUPpnbtc
         tOszWI7hUvCL2y4tDhEo+Knss/b+rKW1sxGbMw4D1xS+GCHNE+nWJwhFBT++Ko4ATABl
         DZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=kiQp4N5lJ5fkGUqdABL1y2dWLEcBUfNEBuKlr/lcaj8=;
        b=1KdlOctQnqLWMvfCs0Xt82HpFLZqkAaf2oamR1rlSiN2wiJDj2qBB57uNX2RwxhqJK
         1ydFrGII4gnY74XjMfwLgUmK8qguwVGgEPM2w97WxwpHrfkQxZvefN3Z+BXdFksRzqo8
         eEDD0SkQqZhGaE2SV8/LqXElVDdvSBalV6pr2BGAjb1fNKgFgbuE01F9HEUjF2e8oS1C
         5r/6YdbzJ4roDG7ZYfm5N2d1vpnz2b+gOUYo6SXKN3mP9+3Y+dpKhiOCAxZxVZZ4tqeh
         eYdAXuHKaM3EBhzlLF4FjdPY2uvQjjYtY/gVeS1ICm8VREyGbZadxEvcMMS6CV/81P47
         iEjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=YMLz5ugK;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=YMLz5ugK;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 19:58:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 06/17] staging: lustre: tidy up ldlm_resource_putref()
In-Reply-To: <152229760841.27689.15144924642603768840.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803301958240.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760841.27689.15144924642603768840.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_195835_171996_67BEC6C7 
X-CRM114-Status: GOOD (  20.01  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244803594692900?=
X-GMAIL-MSGID: =?utf-8?q?1596390185699706860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> 1/ the return value of ldlm_resource_putref() is never
>   used, so change it to return 'void'.
> 2/ Move all of the code to run on the last putref to
>    __ldlm_resource_putref_final().  This means a lock
>    is taken in one function and dropped in another, but
>    that isn't too uncommon, and will disappear in a future
>    patch.
>    Now that the code it together, it becomes apparent that
>    we are dropping a ref on the namespace *before* the last
>    use.  So keep the ref until after.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 +-
>  drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   21 +++++++++-----------
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> index 5a355fbab401..d668d86423a4 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> @@ -1190,7 +1190,7 @@ struct ldlm_resource *ldlm_resource_get(struct ldlm_namespace *ns,
>  					struct ldlm_resource *parent,
>  					const struct ldlm_res_id *,
>  					enum ldlm_type type, int create);
> -int ldlm_resource_putref(struct ldlm_resource *res);
> +void ldlm_resource_putref(struct ldlm_resource *res);
>  void ldlm_resource_add_lock(struct ldlm_resource *res,
>  			    struct list_head *head,
>  			    struct ldlm_lock *lock);
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> index 4c44603ab6f9..8841a1bb2c0a 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> @@ -1195,6 +1195,7 @@ static void __ldlm_resource_putref_final(struct cfs_hash_bd *bd,
>  					 struct ldlm_resource *res)
>  {
>  	struct ldlm_ns_bucket *nsb = res->lr_ns_bucket;
> +	struct ldlm_namespace *ns = nsb->nsb_namespace;
>  
>  	if (!list_empty(&res->lr_granted)) {
>  		ldlm_resource_dump(D_ERROR, res);
> @@ -1206,15 +1207,18 @@ static void __ldlm_resource_putref_final(struct cfs_hash_bd *bd,
>  		LBUG();
>  	}
>  
> -	cfs_hash_bd_del_locked(nsb->nsb_namespace->ns_rs_hash,
> +	cfs_hash_bd_del_locked(ns->ns_rs_hash,
>  			       bd, &res->lr_hash);
>  	lu_ref_fini(&res->lr_reference);
> +	cfs_hash_bd_unlock(ns->ns_rs_hash, bd, 1);
> +	if (ns->ns_lvbo && ns->ns_lvbo->lvbo_free)
> +		ns->ns_lvbo->lvbo_free(res);
>  	if (cfs_hash_bd_count_get(bd) == 0)
> -		ldlm_namespace_put(nsb->nsb_namespace);
> +		ldlm_namespace_put(ns);
> +	kmem_cache_free(ldlm_resource_slab, res);
>  }
>  
> -/* Returns 1 if the resource was freed, 0 if it remains. */
> -int ldlm_resource_putref(struct ldlm_resource *res)
> +void ldlm_resource_putref(struct ldlm_resource *res)
>  {
>  	struct ldlm_namespace *ns = ldlm_res_to_ns(res);
>  	struct cfs_hash_bd   bd;
> @@ -1224,15 +1228,8 @@ int ldlm_resource_putref(struct ldlm_resource *res)
>  	       res, atomic_read(&res->lr_refcount) - 1);
>  
>  	cfs_hash_bd_get(ns->ns_rs_hash, &res->lr_name, &bd);
> -	if (cfs_hash_bd_dec_and_lock(ns->ns_rs_hash, &bd, &res->lr_refcount)) {
> +	if (cfs_hash_bd_dec_and_lock(ns->ns_rs_hash, &bd, &res->lr_refcount))
>  		__ldlm_resource_putref_final(&bd, res);
> -		cfs_hash_bd_unlock(ns->ns_rs_hash, &bd, 1);
> -		if (ns->ns_lvbo && ns->ns_lvbo->lvbo_free)
> -			ns->ns_lvbo->lvbo_free(res);
> -		kmem_cache_free(ldlm_resource_slab, res);
> -		return 1;
> -	}
> -	return 0;
>  }
>  EXPORT_SYMBOL(ldlm_resource_putref);
>  
> 
> 
> 
