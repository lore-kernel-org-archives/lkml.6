Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFANxP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:53:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33561 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeFANxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:53:12 -0400
X-Google-Smtp-Source: ADUXVKLWvU+Oo86daZE4+USUfNdJ1cVEWpMQ0lRGmx8c95ox1XFH81ovfCcybvatplO5qyrxKM1Bfg==
Date: Fri, 1 Jun 2018 15:53:07 +0200
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180601135307.GA28550@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain>
 <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
 <20180528152243.GD1293@localhost.localdomain>
 <CAKfTPtAY26HZ00R02RuW2kvZLvZxHGvh-kbfrqv-hPumdknvWg@mail.gmail.com>
 <20180531102735.GM30654@e110439-lin>
 <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thursday 31 May 2018 à 15:02:04 (+0200), Vincent Guittot a écrit :
> On 31 May 2018 at 12:27, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > Hi Vincent, Juri,
> >
> > On 28-May 18:34, Vincent Guittot wrote:
> >> On 28 May 2018 at 17:22, Juri Lelli <juri.lelli@redhat.com> wrote:
> >> > On 28/05/18 16:57, Vincent Guittot wrote:
> >> >> Hi Juri,
> >> >>
> >> >> On 28 May 2018 at 12:12, Juri Lelli <juri.lelli@redhat.com> wrote:
> >> >> > Hi Vincent,
> >> >> >
> >> >> > On 25/05/18 15:12, Vincent Guittot wrote:
> >> >> >> Now that we have both the dl class bandwidth requirement and the dl class
> >> >> >> utilization, we can use the max of the 2 values when agregating the
> >> >> >> utilization of the CPU.
> >> >> >>
> >> >> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> >> >> ---
> >> >> >>  kernel/sched/sched.h | 6 +++++-
> >> >> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >> >> >>
> >> >> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> >> >> index 4526ba6..0eb07a8 100644
> >> >> >> --- a/kernel/sched/sched.h
> >> >> >> +++ b/kernel/sched/sched.h
> >> >> >> @@ -2194,7 +2194,11 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >> >> >>  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> >> >> >>  static inline unsigned long cpu_util_dl(struct rq *rq)
> >> >> >>  {
> >> >> >> -     return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> >> >> >> +     unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> >> >> >
> >> >> > I'd be tempted to say the we actually want to cap to this one above
> >> >> > instead of using the max (as you are proposing below) or the
> >> >> > (theoretical) power reduction benefits of using DEADLINE for certain
> >> >> > tasks might vanish.
> >> >>
> >> >> The problem that I'm facing is that the sched_entity bandwidth is
> >> >> removed after the 0-lag time and the rq->dl.running_bw goes back to
> >> >> zero but if the DL task has preempted a CFS task, the utilization of
> >> >> the CFS task will be lower than reality and schedutil will set a lower
> >> >> OPP whereas the CPU is always running.
> >
> > With UTIL_EST enabled I don't expect an OPP reduction below the
> > expected utilization of a CFS task.
> 
> I'm not sure to fully catch what you mean but all tests that I ran,
> are using util_est (which is enable by default  if i'm not wrong). So
> all OPP drops that have been observed, were with util_est
> 
> >
> > IOW, when a periodic CFS task is preempted by a DL one, what we use
> > for OPP selection once the DL task is over is still the estimated
> > utilization for the CFS task itself. Thus, schedutil will eventually
> > (since we have quite conservative down scaling thresholds) go down to
> > the right OPP to serve that task.
> >
> >> >> The example with a RT task described in the cover letter can be
> >> >> run with a DL task and will give similar results.
> >
> > In the cover letter you says:
> >
> >    A rt-app use case which creates an always running cfs thread and a
> >    rt threads that wakes up periodically with both threads pinned on
> >    same CPU, show lot of frequency switches of the CPU whereas the CPU
> >    never goes idles during the test.
> >
> > I would say that's a quite specific corner case where your always
> > running CFS task has never accumulated a util_est sample.
> >
> > Do we really have these cases in real systems?
> 
> My example is voluntary an extreme one because it's easier to
> highlight the problem
> 
> >
> > Otherwise, it seems to me that we are trying to solve quite specific
> > corner cases by adding a not negligible level of "complexity".
> 
> By complexity, do you mean :
> 
> Taking into account the number cfs running task to choose between
> rq->dl.running_bw and avg_dl.util_avg
> 
> I'm preparing a patchset that will provide the cfs waiting time in
> addition to dl/rt util_avg for almost no additional cost. I will try
> to sent the proposal later today


The code below adds the tracking of the waiting level of cfs tasks because of
rt/dl preemption. This waiting time can then be used when selecting an OPP
instead of the dl util_avg which could become higher than dl bandwidth with
"long" runtime

We need only one new call for the 1st cfs task that is enqueued to get these additional metrics
the call to arch_scale_cpu_capacity() can be removed once the later will be
taken into account when computing the load (which scales only with freq
currently)

For rt task, we must keep to take into account util_avg to have an idea of the
rt level on the cpu which is given by the badnwodth for dl

---
 kernel/sched/fair.c  | 27 +++++++++++++++++++++++++++
 kernel/sched/pelt.c  |  8 ++++++--
 kernel/sched/sched.h |  4 +++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eac1f9a..1682ea7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5148,6 +5148,30 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static inline void update_cfs_wait_util_avg(struct rq *rq)
+{
+	/*
+	 * If cfs is already enqueued, we don't have anything to do because
+	 * we already updated the non waiting time
+	 */
+	if (rq->cfs.h_nr_running)
+		return;
+
+	/*
+	 * If rt is running, we update the non wait time before increasing
+	 * cfs.h_nr_running)
+	 */
+	if (rq->curr->sched_class == &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+
+	/*
+	 * If dl is running, we update the non time before increasing
+	 * cfs.h_nr_running)
+	 */
+	if (rq->curr->sched_class == &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5159,6 +5183,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/* Update the tracking of waiting time */
+	update_cfs_wait_util_avg(rq);
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a559a53..ef8905e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -322,9 +322,11 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
+	unsigned long waiting = rq->cfs.h_nr_running ? arch_scale_cpu_capacity(NULL, rq->cpu) : 0;
+
 	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
 				running,
-				running,
+				waiting,
 				running)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
@@ -345,9 +347,11 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
+	unsigned long waiting = rq->cfs.h_nr_running ? arch_scale_cpu_capacity(NULL, rq->cpu) : 0;
+
 	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
 				running,
-				running,
+				waiting,
 				running)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ea94de..9f72a05 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2184,7 +2184,9 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 {
 	unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
 
-	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
+	util = max_t(unsigned long, util,
+			     READ_ONCE(rq->avg_dl.runnable_load_avg));
+
 	trace_printk("cpu_util_dl cpu%d %u %lu %llu", rq->cpu,
 						   rq->cfs.h_nr_running,
 						   READ_ONCE(rq->avg_dl.util_avg),
-- 
2.7.4



> 
> >
> > Moreover, I also have the impression that we can fix these
> > use-cases by:
> >
> >   - improving the way we accumulate samples in util_est
> >     i.e. by discarding preemption time
> >
> >   - maybe by improving the utilization aggregation in schedutil to
> >     better understand DL requirements
> >     i.e. a 10% utilization with a 100ms running time is way different
> >     then the same utilization with a 1ms running time
> >
> >
> > --
> > #include <best/regards.h>
> >
> > Patrick Bellasi
