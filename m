Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEPMT4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:19:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEPMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:19:53 -0400
Date: Wed, 16 May 2018 05:19:47 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180516121947.GE20670@bombadil.infradead.org>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526420991-21213-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 05:49:50PM -0400, Waiman Long wrote:
> @@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  
>  	rcu_read_lock();
>  	owner = READ_ONCE(sem->owner);
> -	if (!rwsem_owner_is_writer(owner)) {
> -		/*
> -		 * Don't spin if the rwsem is readers owned.
> -		 */
> -		ret = !rwsem_owner_is_reader(owner);
> +	if (!owner || !is_rwsem_owner_spinnable(owner)) {
> +		ret = !owner;	/* !owner is spinnable */
>  		goto done;
>  	}

This is confusingly written.  I think you mean ...

	if (!owner)
		goto done;
	if (!is_rwsem_owner_spinnable(owner)) {
		ret = false;
		goto done;
	}
