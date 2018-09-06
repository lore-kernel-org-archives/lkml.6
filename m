Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCA2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACCA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeIFTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:12:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:13723 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbeIFTM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:12:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 07:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="gz'50?scan'50,208,50";a="70856799"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2018 07:34:28 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fxvMW-000BDO-Eh; Thu, 06 Sep 2018 22:34:24 +0800
Date:   Thu, 6 Sep 2018 22:34:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <201809062247.Mld5115Y%fengguang.wu@intel.com>
References: <20180904180154.845-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180904180154.845-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/printk-For-early-boot-messages-check-loglevel-when-flushing-the-buffer/20180906-215356
config: parisc-allnoconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   kernel/printk/printk.c: In function 'console_unlock':
>> kernel/printk/printk.c:2377:5: error: implicit declaration of function 'suppress_message_printing' [-Werror=implicit-function-declaration]
        suppress_message_printing(msg->level))) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/suppress_message_printing +2377 kernel/printk/printk.c

  2297	
  2298	/**
  2299	 * console_unlock - unlock the console system
  2300	 *
  2301	 * Releases the console_lock which the caller holds on the console system
  2302	 * and the console driver list.
  2303	 *
  2304	 * While the console_lock was held, console output may have been buffered
  2305	 * by printk().  If this is the case, console_unlock(); emits
  2306	 * the output prior to releasing the lock.
  2307	 *
  2308	 * If there is output waiting, we wake /dev/kmsg and syslog() users.
  2309	 *
  2310	 * console_unlock(); may be called from any context.
  2311	 */
  2312	void console_unlock(void)
  2313	{
  2314		static char ext_text[CONSOLE_EXT_LOG_MAX];
  2315		static char text[LOG_LINE_MAX + PREFIX_MAX];
  2316		unsigned long flags;
  2317		bool do_cond_resched, retry;
  2318	
  2319		if (console_suspended) {
  2320			up_console_sem();
  2321			return;
  2322		}
  2323	
  2324		/*
  2325		 * Console drivers are called with interrupts disabled, so
  2326		 * @console_may_schedule should be cleared before; however, we may
  2327		 * end up dumping a lot of lines, for example, if called from
  2328		 * console registration path, and should invoke cond_resched()
  2329		 * between lines if allowable.  Not doing so can cause a very long
  2330		 * scheduling stall on a slow console leading to RCU stall and
  2331		 * softlockup warnings which exacerbate the issue with more
  2332		 * messages practically incapacitating the system.
  2333		 *
  2334		 * console_trylock() is not able to detect the preemptive
  2335		 * context reliably. Therefore the value must be stored before
  2336		 * and cleared after the the "again" goto label.
  2337		 */
  2338		do_cond_resched = console_may_schedule;
  2339	again:
  2340		console_may_schedule = 0;
  2341	
  2342		/*
  2343		 * We released the console_sem lock, so we need to recheck if
  2344		 * cpu is online and (if not) is there at least one CON_ANYTIME
  2345		 * console.
  2346		 */
  2347		if (!can_use_console()) {
  2348			console_locked = 0;
  2349			up_console_sem();
  2350			return;
  2351		}
  2352	
  2353		for (;;) {
  2354			struct printk_log *msg;
  2355			size_t ext_len = 0;
  2356			size_t len;
  2357	
  2358			printk_safe_enter_irqsave(flags);
  2359			raw_spin_lock(&logbuf_lock);
  2360			if (console_seq < log_first_seq) {
  2361				len = sprintf(text, "** %u printk messages dropped **\n",
  2362					      (unsigned)(log_first_seq - console_seq));
  2363	
  2364				/* messages are gone, move to first one */
  2365				console_seq = log_first_seq;
  2366				console_idx = log_first_idx;
  2367			} else {
  2368				len = 0;
  2369			}
  2370	skip:
  2371			if (console_seq == log_next_seq)
  2372				break;
  2373	
  2374			msg = log_from_idx(console_idx);
  2375			if ((msg->flags & LOG_NOCONS) ||
  2376			    ((msg->flags & LOG_CHK_LEVEL) &&
> 2377					suppress_message_printing(msg->level))) {
  2378				/*
  2379				 * Skip record if !ignore_loglevel, and
  2380				 * record has level above the console loglevel.
  2381				 */
  2382				console_idx = log_next(console_idx);
  2383				console_seq++;
  2384				goto skip;
  2385			}
  2386	
  2387			len += msg_print_text(msg,
  2388					console_msg_format & MSG_FORMAT_SYSLOG,
  2389					text + len,
  2390					sizeof(text) - len);
  2391			if (nr_ext_console_drivers) {
  2392				ext_len = msg_print_ext_header(ext_text,
  2393							sizeof(ext_text),
  2394							msg, console_seq);
  2395				ext_len += msg_print_ext_body(ext_text + ext_len,
  2396							sizeof(ext_text) - ext_len,
  2397							log_dict(msg), msg->dict_len,
  2398							log_text(msg), msg->text_len);
  2399			}
  2400			console_idx = log_next(console_idx);
  2401			console_seq++;
  2402			raw_spin_unlock(&logbuf_lock);
  2403	
  2404			/*
  2405			 * While actively printing out messages, if another printk()
  2406			 * were to occur on another CPU, it may wait for this one to
  2407			 * finish. This task can not be preempted if there is a
  2408			 * waiter waiting to take over.
  2409			 */
  2410			console_lock_spinning_enable();
  2411	
  2412			stop_critical_timings();	/* don't trace print latency */
  2413			call_console_drivers(ext_text, ext_len, text, len);
  2414			start_critical_timings();
  2415	
  2416			if (console_lock_spinning_disable_and_check()) {
  2417				printk_safe_exit_irqrestore(flags);
  2418				return;
  2419			}
  2420	
  2421			printk_safe_exit_irqrestore(flags);
  2422	
  2423			if (do_cond_resched)
  2424				cond_resched();
  2425		}
  2426	
  2427		console_locked = 0;
  2428	
  2429		/* Release the exclusive_console once it is used */
  2430		if (unlikely(exclusive_console))
  2431			exclusive_console = NULL;
  2432	
  2433		raw_spin_unlock(&logbuf_lock);
  2434	
  2435		up_console_sem();
  2436	
  2437		/*
  2438		 * Someone could have filled up the buffer again, so re-check if there's
  2439		 * something to flush. In case we cannot trylock the console_sem again,
  2440		 * there's a new owner and the console_unlock() from them will do the
  2441		 * flush, no worries.
  2442		 */
  2443		raw_spin_lock(&logbuf_lock);
  2444		retry = console_seq != log_next_seq;
  2445		raw_spin_unlock(&logbuf_lock);
  2446		printk_safe_exit_irqrestore(flags);
  2447	
  2448		if (retry && console_trylock())
  2449			goto again;
  2450	}
  2451	EXPORT_SYMBOL(console_unlock);
  2452	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lrZ03NoBR/3+SXJZ--
