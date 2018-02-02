Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBBXCa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:02:30 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:36286 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbeBBXCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:02:25 -0500
Date: Fri, 2 Feb 2018 23:02:20 +0000
From: Sergei Trofimovich <slyfox@gentoo.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_GETREGS) (unbreaks strace, gdb)
Message-ID: <20180202230220.13b74e8c@sf>
In-Reply-To: <20180202222231.23favlxecnxcencr@agluck-desk>
References: <20180202221224.16597-1-slyfox@gentoo.org>
        <20180202222231.23favlxecnxcencr@agluck-desk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018 14:22:32 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Fri, Feb 02, 2018 at 10:12:24PM +0000, Sergei Trofimovich wrote:
> > The strace breakage looks like that:
> > ./strace: get_regs: get_regs_error: Input/output error
> > 
> > It happens because ia64 needs to load unwind tables
> > to read certain registers. Unwind tables fail to load
> > due to GCC quirk on the following code:
> > 
> >     extern char __end_unwind[];
> >     const struct unw_table_entry *end = (struct unw_table_entry *)table_end;
> >     table->end = segment_base + end[-1].end_offset;
> > 
> > GCC does not generate correct code for this single memory
> > reference after constant propagation (see https://gcc.gnu.org/PR84184).  
> 
> I'm not seeing this ... probably because I build with
> a pre-historic 4.3.4 version of gcc.
> 
> Do you know which version(s) are affected? I'm not looking
> for an exhaustive list, just the one on which you found this
> would be good.
> 
> -Tony

Original bug https://bugs.gentoo.org/518130 claims regression appeared
around gcc-4.5. Locally am seeing the problem with gcc-6.4.0, gcc-7.2.0 and
gcc-8 (HEAD).

-- 

  Sergei
