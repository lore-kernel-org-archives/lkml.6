Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbeEHPnD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754986AbeEHPnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:43:01 -0400
Date: Wed, 9 May 2018 00:42:57 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: jolsa@redhat.com, acme@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH v2 3/3] perf/buildid-cache: Support --purge-all option
Message-Id: <20180509004257.9ad74de57b9e0f90ad5e7e81@kernel.org>
In-Reply-To: <b72d8419-2933-d241-2662-899a72032aa8@linux.ibm.com>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180417041346.5617-4-ravi.bangoria@linux.vnet.ibm.com>
        <20180423160219.b58fdc600e5d6927105ba57b@kernel.org>
        <b72d8419-2933-d241-2662-899a72032aa8@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018 14:24:04 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Masami,
> 
> On 04/23/2018 12:32 PM, Masami Hiramatsu wrote:
> > On Tue, 17 Apr 2018 09:43:46 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >> +	pr_debug("Purged all: %s\n", err ? "FAIL" : "Ok");
> > Hmm, I think this should use pr_info(or pr_warning), at least for Failure case.
> 
> Actually, I followed what is already there for other options.

Please see cmd_buildid_cache(), if we failed to purge one buildid-cache,
it is warned with pr_warning.

	if (purge_name_list_str) {
		list = strlist__new(purge_name_list_str, NULL);
		if (list) {
			strlist__for_each_entry(pos, list)
				if (build_id_cache__purge_path(pos->s, nsi)) {
					if (errno == ENOENT) {
						pr_debug("%s wasn't in the cache\n",
							 pos->s);
						continue;
					}
					pr_warning("Couldn't remove %s: %s\n",
						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
				}

			strlist__delete(list);
		}
	}

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
