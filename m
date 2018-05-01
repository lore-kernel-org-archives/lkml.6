Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeEAORF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:17:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753072AbeEAORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:17:04 -0400
Date: Tue, 1 May 2018 07:18:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC v5 3/6] srcu: Add notrace variant of srcu_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180501014204.67548-1-joelaf@google.com>
 <20180501014204.67548-4-joelaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501014204.67548-4-joelaf@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050114-0056-0000-0000-00000447E1CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008956; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025961; UDB=6.00523953; IPR=6.00805192;
 MB=3.00020880; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 14:17:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050114-0057-0000-0000-0000088BE797
Message-Id: <20180501141817.GE26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 06:42:01PM -0700, Joel Fernandes wrote:
> In this series, we are making lockdep use an rcuidle tracepoint. For
> this reason we need a notrace variant of srcu_dereference since
> otherwise we get lockdep splats since lockdep hooks may not have run
> yet. This patch adds the needed variant.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  include/linux/srcu.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 2ec618979b20..a1c4947be877 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -135,6 +135,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
>   */
>  #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
> 
> +/**
> + * srcu_dereference_notrace - no tracing and no lockdep calls from here
> + */
> +#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)

Given that this is a one-liner, why not just use srcu_dereference_check()
directly, with 1 as you do above to disable lockdep?

							Thanx, Paul

> +
>  /**
>   * srcu_read_lock - register a new reader for an SRCU-protected structure.
>   * @sp: srcu_struct in which to register the new reader.
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
