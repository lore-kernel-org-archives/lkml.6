Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeCNF2M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:28:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753270AbeCNF2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:28:11 -0400
Date: Wed, 14 Mar 2018 01:23:27 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak21 V2 3/4] audit: add refused symlink to audit_names
Message-ID: <20180314052327.3uhxb6iy5xtrs3ml@madcap2.tricolour.ca>
References: <ce98e9600a8d7d0169067ae9f3e3a5ae2fb1f54a.1520835596.git.rgb@redhat.com>
 <CAHC9VhRh094wMJkiBY+iStfwMEotHMrOCWUSW23gva_ccknuqg@mail.gmail.com>
 <20180312152614.qvcxng3biug46lms@madcap2.tricolour.ca>
 <CAHC9VhR-2tQAsDHDNto7GWkSrCLWGuURexxsxDxECfY9KoVvww@mail.gmail.com>
 <20180312155256.4j7uglv7jiyppozm@madcap2.tricolour.ca>
 <20180313093517.28c99b48@ivy-bridge>
 <20180313101108.s6o7jec57rsxpsmc@madcap2.tricolour.ca>
 <20180313113815.187da185@ivy-bridge>
 <20180313105251.p7pc472xyklm7ssr@madcap2.tricolour.ca>
 <CAHC9VhQ+JwGd3FOU_oZVgQRt=MAcyeDxDiZv8GWtXF3bYLp+dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ+JwGd3FOU_oZVgQRt=MAcyeDxDiZv8GWtXF3bYLp+dQ@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-13 16:24, Paul Moore wrote:
> On Tue, Mar 13, 2018 at 6:52 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-03-13 11:38, Steve Grubb wrote:
> >> On Tue, 13 Mar 2018 06:11:08 -0400
> >> Richard Guy Briggs <rgb@redhat.com> wrote:
> >>
> >> > On 2018-03-13 09:35, Steve Grubb wrote:
> >> > > On Mon, 12 Mar 2018 11:52:56 -0400
> >> > > Richard Guy Briggs <rgb@redhat.com> wrote:
> >> > >
> >> > > > On 2018-03-12 11:53, Paul Moore wrote:
> >> > > > > On Mon, Mar 12, 2018 at 11:26 AM, Richard Guy Briggs
> >> > > > > <rgb@redhat.com> wrote:
> >> > > > > > On 2018-03-12 11:12, Paul Moore wrote:
> >> > > > > >> On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs
> >> > > > > >> <rgb@redhat.com> wrote:
> >> > > > > >> > Audit link denied events for symlinks had duplicate PATH
> >> > > > > >> > records rather than just updating the existing PATH record.
> >> > > > > >> > Update the symlink's PATH record with the current dentry
> >> > > > > >> > and inode information.
> >> > > > > >> >
> >> > > > > >> > See: https://github.com/linux-audit/audit-kernel/issues/21
> >> > > > > >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> > > > > >> > ---
> >> > > > > >> >  fs/namei.c | 1 +
> >> > > > > >> >  1 file changed, 1 insertion(+)
> >> > > > > >>
> >> > > > > >> Why didn't you include this in patch 4/4 like I asked during
> >> > > > > >> the previous review?
> >> > > > > >
> >> > > > > > Please see the last comment of:
> >> > > > > > https://www.redhat.com/archives/linux-audit/2018-March/msg00070.html
> >> > > > >
> >> > > > > Yes, I just saw that ... I hadn't seen your replies on the v1
> >> > > > > patches until I had finished reviewing v2.  I just replied to
> >> > > > > that mail in the v1 thread, but basically you need to figure
> >> > > > > out what is necessary here and let us know.  If I have to
> >> > > > > figure it out it likely isn't going to get done with enough
> >> > > > > soak time prior to the upcoming merge window.
> >> > > >
> >> > > > Steve?  I was hoping you could chime in here.
> >> > >
> >> > > If the CWD record will always be the same as the PARENT record,
> >> > > then we do not need the parent record. Duplicate information is
> >> > > bad. Like all the duplicate SYSCALL information.
> >> >
> >> > The CWD record could be different from the PARENT record, since I
> >> > could have SYMLINK=/tmp/test/symlink, CWD=/tmp, PARENT=/tmp/test.
> >> > Does the parent record even matter since it might not be a directory
> >> > operation like creat, unlink or rename?
> >>
> >> There's 2 issues. One is creating the path if what we have is relative.
> >> In this situation CWD should be enough. But if the question is whether
> >> the PARENT directory should be included...what if the PARENT
> >> permissions do not allow the successful name resolution? In that case
> >> we might only get a PARENT record no? In that case we would need it.
> >
> > I think in the case of symlink creation, normal file create code path
> > would be in effect, and would properly log parent and symlink source
> > file paths (if a rule to log it was in effect) which is not something
> > that would trigger a symlink link denied error.  Symlink link denied
> > happens only when trying to actually follow the link before
> > resolving the target path of a read/write/exec of the symlink target.
> >
> > If the parent permissions of the link's target don't allow successful
> > name resolution then the symlink link denied condition isn't met, but
> > rather any other rule that applies to the target path.
> 
> I'm guessing you are in the process of tracking all this down, but if
> not, lets get to a point where we can answer this definitively and not
> guess :)

I was fairly certain but being polite, expecting confirmation or
possibly correction if I've overlooked something.

Additionally, this denial message only happens in certain parts of the
permission check for symlinks:
	/proc/sys/fs/protected_symlinks == 1
	and follower and link owner don't match
	and parent sticky and world-writable
	and link parent and link owner don't match

If you want other symlink denials logged, you need to set a rule for the
target filtering on operation failure such as unix file permissions.

The similar situation exists for hardlinks.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
