Date: Fri, 6 Apr 2018 09:03:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 014/134] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Message-ID: <20180406070316.GC8416@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171851.147448695@linuxfoundation.org>
 <1522340036.2654.20.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522340036.2654.20.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 05:13:56PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:04 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Stephane Eranian <eranian@google.com>
> > 
> > 
> > [ Upstream commit 88b897a30c525c2eee6e7f16e1e8d0f18830845e ]
> > 
> > This patch significantly improves the execution time of
> > perf_event__synthesize_mmap_events() when running perf record on systems
> > where processes have lots of threads.
> > 
> > It just happens that cat /proc/pid/maps support uses a O(N^2) algorithm to
> > generate each map line in the maps file.  If you have 1000 threads, then you
> > have necessarily 1000 stacks.  For each vma, you need to check if it
> > corresponds to a thread's stack.  With a large number of threads, this can take
> > a very long time. I have seen latencies >> 10mn.
> > 
> > As of today, perf does not use the fact that a mapping is a stack, therefore we
> > can work around the issue by using /proc/pid/tasks/pid/maps.  This entry does
> > not try to map a vma to stack and is thus much faster with no loss of
> > functonality.
> > 
> > The proc-map-timeout logic is kept in case users still want some upper limit.
> > 
> > In V2, we fix the file path from /proc/pid/tasks/pid/maps to actual
> > /proc/pid/task/pid/maps, tasks -> task.  Thanks Arnaldo for catching this.
> > 
> > Committer note:
> > 
> > This problem seems to have been elliminated in the kernel since commit :
> > b18cb64ead40 ("fs/proc: Stop trying to report thread stacks").
> [...]
> 
> I don't think so.  It looks like this was fixed by commit 65376df58217
> ("proc: revert /proc/<pid>/maps [stack:TID] annotation") which we
> already have in 4.4-stable.  But older branches (3.16, 3.18, 4.1) don't
> have that and probably should do.

Now added to 3.18.y

> It looks like commit b18cb64ead40 ("fs/proc: Stop trying to report
> thread stacks") is also a candidate for stable.

Now added to 3.18.y and 4.4.y, thanks!

greg k-h
