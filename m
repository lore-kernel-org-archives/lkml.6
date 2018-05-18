Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeERHDE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:03:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39474 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:03:02 -0400
X-Google-Smtp-Source: AB8JxZqYLm+IfirOtmx7g5m8NZb+LH+corDe1QSdRf3nuYyFF9OkcGrADfosbDFbD3i5FFWMyau+Eg==
Date: Fri, 18 May 2018 09:02:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180518070258.GA20971@gmail.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516121947.GE20670@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516121947.GE20670@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 15, 2018 at 05:49:50PM -0400, Waiman Long wrote:
> > @@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> >  
> >  	rcu_read_lock();
> >  	owner = READ_ONCE(sem->owner);
> > -	if (!rwsem_owner_is_writer(owner)) {
> > -		/*
> > -		 * Don't spin if the rwsem is readers owned.
> > -		 */
> > -		ret = !rwsem_owner_is_reader(owner);
> > +	if (!owner || !is_rwsem_owner_spinnable(owner)) {
> > +		ret = !owner;	/* !owner is spinnable */
> >  		goto done;
> >  	}
> 
> This is confusingly written.  I think you mean ...
> 
> 	if (!owner)
> 		goto done;
> 	if (!is_rwsem_owner_spinnable(owner)) {
> 		ret = false;
> 		goto done;
> 	}

Yes, that's cleaner. Waiman, mind sending a followup patch that cleans this up?

Thanks,

	Ingo
