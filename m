Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936094AbeEYI2j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:28:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935978AbeEYI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:28:36 -0400
Subject: Re: [PATCH v3 6/9] trace_uprobe: Support SDT markers having reference
 count (semaphore)
To: Oleg Nesterov <oleg@redhat.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180417043244.7501-7-ravi.bangoria@linux.vnet.ibm.com>
 <20180524162608.GA27082@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Fri, 25 May 2018 13:58:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524162608.GA27082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052508-0020-0000-0000-000004211FEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052508-0021-0000-0000-000042B66706
Message-Id: <db01028c-3bbf-00da-47a4-6f6c1f5229b3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250102
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Oleg for the review,

On 05/24/2018 09:56 PM, Oleg Nesterov wrote:
> On 04/17, Ravi Bangoria wrote:
>>
>> @@ -941,6 +1091,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
>>  	if (ret)
>>  		goto err_buffer;
>>  
>> +	if (tu->ref_ctr_offset)
>> +		sdt_increment_ref_ctr(tu);
>> +
> 
> iiuc, this is probe_event_enable()...
> 
> Looks racy, but afaics the race with uprobe_mmap() will be closed by the next
> change. However, it seems that probe_event_disable() can race with trace_uprobe_mmap()
> too and the next 7/9 patch won't help,
> 
>> +	if (tu->ref_ctr_offset)
>> +		sdt_decrement_ref_ctr(tu);
>> +
>>  	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>>  	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
> 
> so what if trace_uprobe_mmap() comes right after uprobe_unregister() ?
> Note that trace_probe_is_enabled() is T until we update tp.flags.

Sure, I'll look at your comments.

Apart from these, I've also found a deadlock between uprobe_lock and
mm->mmap_sem. trace_uprobe_mmap() takes these locks in

   mm->mmap_sem
      uprobe_lock

order but some other code path is taking these locks in reverse order. I've
mentioned sample lockdep warning at the end. The issue is, mm->mmap_sem is
not in control of trace_uprobe_mmap() and we have to take uprobe_lock to
loop over all trace_uprobes.

Any idea how this can be resolved?


Sample lockdep warning:

[  499.258006] ======================================================
[  499.258205] WARNING: possible circular locking dependency detected
[  499.258409] 4.17.0-rc3+ #76 Not tainted
[  499.258528] ------------------------------------------------------
[  499.258731] perf/6744 is trying to acquire lock:
[  499.258895] 00000000e4895f49 (uprobe_lock){+.+.}, at: trace_uprobe_mmap+0x78/0x130
[  499.259147]
[  499.259147] but task is already holding lock:
[  499.259349] 000000009ec93a76 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xe0/0x160
[  499.259597]
[  499.259597] which lock already depends on the new lock.
[  499.259597]
[  499.259848]
[  499.259848] the existing dependency chain (in reverse order) is:
[  499.260086]
[  499.260086] -> #4 (&mm->mmap_sem){++++}:
[  499.260277]        __lock_acquire+0x53c/0x910
[  499.260442]        lock_acquire+0xf4/0x2f0
[  499.260595]        down_write_killable+0x6c/0x150
[  499.260764]        copy_process.isra.34.part.35+0x1594/0x1be0
[  499.260967]        _do_fork+0xf8/0x910
[  499.261090]        ppc_clone+0x8/0xc
[  499.261209]
[  499.261209] -> #3 (&dup_mmap_sem){++++}:
[  499.261378]        __lock_acquire+0x53c/0x910
[  499.261540]        lock_acquire+0xf4/0x2f0
[  499.261669]        down_write+0x6c/0x110
[  499.261793]        percpu_down_write+0x48/0x140
[  499.261954]        register_for_each_vma+0x6c/0x2a0
[  499.262116]        uprobe_register+0x230/0x320
[  499.262277]        probe_event_enable+0x1cc/0x540
[  499.262435]        perf_trace_event_init+0x1e0/0x350
[  499.262587]        perf_trace_init+0xb0/0x110
[  499.262750]        perf_tp_event_init+0x38/0x90
[  499.262910]        perf_try_init_event+0x10c/0x150
[  499.263075]        perf_event_alloc+0xbb0/0xf10
[  499.263235]        sys_perf_event_open+0x2a8/0xdd0
[  499.263396]        system_call+0x58/0x6c
[  499.263516]
[  499.263516] -> #2 (&uprobe->register_rwsem){++++}:
[  499.263723]        __lock_acquire+0x53c/0x910
[  499.263884]        lock_acquire+0xf4/0x2f0
[  499.264002]        down_write+0x6c/0x110
[  499.264118]        uprobe_register+0x1ec/0x320
[  499.264283]        probe_event_enable+0x1cc/0x540
[  499.264442]        perf_trace_event_init+0x1e0/0x350
[  499.264603]        perf_trace_init+0xb0/0x110
[  499.264766]        perf_tp_event_init+0x38/0x90
[  499.264930]        perf_try_init_event+0x10c/0x150
[  499.265092]        perf_event_alloc+0xbb0/0xf10
[  499.265261]        sys_perf_event_open+0x2a8/0xdd0
[  499.265424]        system_call+0x58/0x6c
[  499.265542]
[  499.265542] -> #1 (event_mutex){+.+.}:
[  499.265738]        __lock_acquire+0x53c/0x910
[  499.265896]        lock_acquire+0xf4/0x2f0
[  499.266019]        __mutex_lock+0xa0/0xab0
[  499.266142]        trace_add_event_call+0x44/0x100
[  499.266310]        create_trace_uprobe+0x4a0/0x8b0
[  499.266474]        trace_run_command+0xa4/0xc0
[  499.266631]        trace_parse_run_command+0xe4/0x200
[  499.266799]        probes_write+0x20/0x40
[  499.266922]        __vfs_write+0x6c/0x240
[  499.267041]        vfs_write+0xd0/0x240
[  499.267166]        ksys_write+0x6c/0x110
[  499.267295]        system_call+0x58/0x6c
[  499.267413]
[  499.267413] -> #0 (uprobe_lock){+.+.}:
[  499.267591]        validate_chain.isra.34+0xbd0/0x1000
[  499.267747]        __lock_acquire+0x53c/0x910
[  499.267917]        lock_acquire+0xf4/0x2f0
[  499.268048]        __mutex_lock+0xa0/0xab0
[  499.268170]        trace_uprobe_mmap+0x78/0x130
[  499.268335]        uprobe_mmap+0x80/0x3b0
[  499.268464]        mmap_region+0x290/0x660
[  499.268590]        do_mmap+0x40c/0x500
[  499.268718]        vm_mmap_pgoff+0x114/0x160
[  499.268870]        ksys_mmap_pgoff+0xe8/0x2e0
[  499.269034]        sys_mmap+0x84/0xf0
[  499.269161]        system_call+0x58/0x6c
[  499.269279]
[  499.269279] other info that might help us debug this:
[  499.269279]
[  499.269524] Chain exists of:
[  499.269524]   uprobe_lock --> &dup_mmap_sem --> &mm->mmap_sem
[  499.269524]
[  499.269856]  Possible unsafe locking scenario:
[  499.269856]
[  499.270058]        CPU0                    CPU1
[  499.270223]        ----                    ----
[  499.270384]   lock(&mm->mmap_sem);
[  499.270514]                                lock(&dup_mmap_sem);
[  499.270711]                                lock(&mm->mmap_sem);
[  499.270923]   lock(uprobe_lock);
[  499.271046]
[  499.271046]  *** DEADLOCK ***
[  499.271046]
[  499.271256] 1 lock held by perf/6744:
[  499.271377]  #0: 000000009ec93a76 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xe0/0x160
[  499.271628]
[  499.271628] stack backtrace:
[  499.271797] CPU: 25 PID: 6744 Comm: perf Not tainted 4.17.0-rc3+ #76
[  499.272003] Call Trace:
[  499.272094] [c0000000e32d74a0] [c000000000b00174] dump_stack+0xe8/0x164 (unreliable)
[  499.272349] [c0000000e32d74f0] [c0000000001a905c] print_circular_bug.isra.30+0x354/0x388
[  499.272590] [c0000000e32d7590] [c0000000001a3050] check_prev_add.constprop.38+0x8f0/0x910
[  499.272828] [c0000000e32d7690] [c0000000001a3c40] validate_chain.isra.34+0xbd0/0x1000
[  499.273070] [c0000000e32d7780] [c0000000001a57cc] __lock_acquire+0x53c/0x910
[  499.273311] [c0000000e32d7860] [c0000000001a65b4] lock_acquire+0xf4/0x2f0
[  499.273510] [c0000000e32d7930] [c000000000b1d1f0] __mutex_lock+0xa0/0xab0
[  499.273717] [c0000000e32d7a40] [c0000000002b01b8] trace_uprobe_mmap+0x78/0x130
[  499.273952] [c0000000e32d7a90] [c0000000002d7070] uprobe_mmap+0x80/0x3b0
[  499.274153] [c0000000e32d7b20] [c0000000003550a0] mmap_region+0x290/0x660
[  499.274353] [c0000000e32d7c00] [c00000000035587c] do_mmap+0x40c/0x500
[  499.274560] [c0000000e32d7c80] [c00000000031ebc4] vm_mmap_pgoff+0x114/0x160
[  499.274763] [c0000000e32d7d60] [c000000000352818] ksys_mmap_pgoff+0xe8/0x2e0
[  499.275013] [c0000000e32d7de0] [c000000000016864] sys_mmap+0x84/0xf0
[  499.275207] [c0000000e32d7e30] [c00000000000b404] system_call+0x58/0x6c
