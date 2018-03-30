Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx48IuUopKAdxJC5t+/hB+tbbGHF5x9XmCxmu5mfNa84mQmNWlOu0dzdR2nN3tbGNvlEbkKJG
ARC-Seal: i=1; a=rsa-sha256; t=1522436342; cv=none;
        d=google.com; s=arc-20160816;
        b=JmX6anROvcLRavfiDUsPW6HcyJ/4x7BfZqq2TGx0XDyMS911StfXGJ6+xRfB/almyG
         gd7N8KkjbqNfvZ6yiD9cofWLt9wNSF1AvNRlaqJ8ycCSUDKKR14J3XdxjCsIwKoCWGtK
         Q0TQAvCoIhMp0FlfhR6AuQtZPJkWeOZCb9RW37hbJwLCL+XnWv4tIwesWqGoxOP05ZAx
         OYeQVm86Y5nKojZjzEfQe7dSlgu/vMDrZ8fBh0Y9h9EHcrStXNug1kCNpCzxBD0JOJKs
         fgBlk00+m2d4Dg3qQ8TjpUH53LI4Asn0nNrv8/VQHNjnKp6w8svx1vP5HanvxloyOY/C
         /YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=7nlS8zOgVz0DZso8tUONr+YS5UXjC6KNm4ao5aC2JYY=;
        b=thdyTLNkOYNF+tZldCFK6+TgzmV2ISeBCqsaFjup4keY7iTq65ouCFHa1Ytq9519Gr
         8NWC83NdT3BPDKcVClZBOVxWZb+7+dNyfkUUa7sZopoXod6gRrm/FTf4IWsT0BJwgQl7
         hYErpjuHBXAnsvv53ZRlNpeqUfUKUDjrapKavi1k6frTjDhsxT3pKPcVqflexH57Tl/W
         47leqSXrQ2opoWGqHxtp7m3xQziKHXBOkq8dhsxtiBUtiRTwcOt/2jmB+RvItYsaqkuH
         1ZctbWa6NGi0l9QpaEd+ZJ/jbVzTErv198JqB21s730p1sz/ADLmy1lybY4J8wHgttX+
         SJpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=uugA9gOi;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=uugA9gOi;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 19:58:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 07/17] staging: lustre: ldlm: free resource when
 ldlm_lock_create() fails.
In-Reply-To: <152229760844.27689.4330202028940942080.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803301958530.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760844.27689.4330202028940942080.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_195859_138900_75C14FE4 
X-CRM114-Status: GOOD (  13.97  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244811383185492?=
X-GMAIL-MSGID: =?utf-8?q?1596390210597141983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> ldlm_lock_create() gets a resource, but don't put it on
> all failure paths. It should.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/ldlm/ldlm_lock.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
> index b8fd778d9832..614caa4a9b0e 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
> @@ -1551,8 +1551,10 @@ struct ldlm_lock *ldlm_lock_create(struct ldlm_namespace *ns,
>  		return ERR_CAST(res);
>  
>  	lock = ldlm_lock_new(res);
> -	if (!lock)
> +	if (!lock) {
> +		ldlm_resource_putref(res);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	lock->l_req_mode = mode;
>  	lock->l_ast_data = data;
> @@ -1595,6 +1597,8 @@ struct ldlm_lock *ldlm_lock_create(struct ldlm_namespace *ns,
>  	return ERR_PTR(rc);
>  }
>  
> +
> +
>  /**
>   * Enqueue (request) a lock.
>   * On the client this is called from ldlm_cli_enqueue_fini
> 
> 
> 
