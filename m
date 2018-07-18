Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7803AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A402084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A402084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeGRU0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:26:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39272 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:26:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ffsPF-0003pr-Bl; Wed, 18 Jul 2018 19:46:37 +0000
Date:   Wed, 18 Jul 2018 20:46:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] call_with_creds()
Message-ID: <20180718194637.GV30522@ZenIV.linux.org.uk>
References: <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk>
 <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk>
 <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk>
 <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:19:18AM -0700, Linus Torvalds wrote:
> On Wed, Jul 18, 2018 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Linus, David - do you have any objections to the above?
> 
> I damn well do.
> 
> I explained earlier why it's wrong and fragile, and why it can just
> cause the *reverse* security problem if you do it wrong. So now you
> take a subtle bug, and make it even more subtle, and encourage people
> to do this known-broken model of using creds at IO time.
> 
> No.
> 
> Some debugging option to just clear current->creds entirely and catch
> mis-uses, sure. But saying "we have shit buggy garbage in random write
> functions, so we'll just paper over it"? No.

Huh?  Nevermind ->write(), what about open()?  Here's a specific question
Miklos brought when I suggested to get rid of that override:
/*
 * These allocate and release file read/write context information.
 */
int nfs_open(struct inode *inode, struct file *filp)
{
        struct nfs_open_context *ctx;

        ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);

struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
                                                fmode_t f_mode,
                                                struct file *filp)
{
        struct nfs_open_context *ctx;
        struct rpc_cred *cred = rpc_lookup_cred();

struct rpc_cred *rpc_lookup_cred(void)
{
        return rpcauth_lookupcred(&generic_auth, 0);

struct rpc_cred *
rpcauth_lookupcred(struct rpc_auth *auth, int flags)
{
        struct auth_cred acred;
        struct rpc_cred *ret;
        const struct cred *cred = current_cred();

How should we bring the cred passed to do_dentry_open() where open() has been
called to rpcauth_lookupcred() where we end up looking for rpc_cred by what
should've been the cred passed to do_dentry_open() and is, instead, current_cred()?

We can pass filp->f_cred to rpc_lookup_cred() variant that gets it as an explicit
argument and feed it down to rpcauth_lookupcred() variant that does the same.
We can basically ignore the ->f_cred here.  Or we can get current_cred() equal
to ->f_cred for the duration of open().

I'd probably prefer the first variant, but the last part of the question Miklos
asked
> Okay, so ->open() is a file op, and file ops should use file->f_cred,
> but how are we going to enforce this?
is not trivial - how do we find the places where that kind of thing happens and
what do we do in the meanwhile?  I don't see any quick answers - any suggestions
would be very welcome.  It's not just direct current_cred() callers; that stuff
gets called deep in call chains.  And lifting it all the way up means a lot of
methods that need to get an explicit struct cred * argument.  Are you OK with
going in that direction?

I'm honestly not sure - it's not an attempt to maneuver you into changing your
policy re ->write().  Do we care about ->f_cred at all and if we do, how do we
get it consistent across the filesystems?  I'd buy "it's a weird and obscure thing"
for overlayfs, but that example is on NFS...

We definitely do have bugs in that area - consider e.g.
static int ecryptfs_threadfn(void *ignored)
{
        set_freezable();
        while (1)  {
                struct ecryptfs_open_req *req;

                wait_event_freezable(
                        ecryptfs_kthread_ctl.wait,
                        (!list_empty(&ecryptfs_kthread_ctl.req_list)
                         || kthread_should_stop()));
                mutex_lock(&ecryptfs_kthread_ctl.mux);
                if (ecryptfs_kthread_ctl.flags & ECRYPTFS_KTHREAD_ZOMBIE) {
                        mutex_unlock(&ecryptfs_kthread_ctl.mux);
                        goto out;
                }
                while (!list_empty(&ecryptfs_kthread_ctl.req_list)) {
                        req = list_first_entry(&ecryptfs_kthread_ctl.req_list,
                                               struct ecryptfs_open_req,
                                               kthread_ctl_list);
                        list_del(&req->kthread_ctl_list);
                        *req->lower_file = dentry_open(&req->path,
                                (O_RDWR | O_LARGEFILE), current_cred());
                        complete(&req->done);
                }
                mutex_unlock(&ecryptfs_kthread_ctl.mux);
        }
out:
        return 0;
}

It's a kernel thread, so current_cred() looks bogus...
