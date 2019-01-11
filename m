Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DF920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfAKDIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:08:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:39122 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbfAKDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:08:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 19:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="gz'50?scan'50,208,50";a="266271097"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2019 19:08:30 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ghnBN-000Dni-Pa; Fri, 11 Jan 2019 11:08:29 +0800
Date:   Fri, 11 Jan 2019 11:07:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Todd Kjos <tkjos@android.com>
Cc:     kbuild-all@01.org, tkjos@google.com, gregkh@linuxfoundation.org,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: create node flag to request sender's security
 context
Message-ID: <201901111127.eu6p93JV%fengguang.wu@intel.com>
References: <20190110182100.186199-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20190110182100.186199-1-tkjos@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Todd,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc1 next-20190110]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Todd-Kjos/binder-create-node-flag-to-request-sender-s-security-context/20190111-095225
config: i386-randconfig-x009-201901 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/android/binder.c: In function 'binder_transaction':
>> drivers/android/binder.c:3067:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      t->security_ctx = (binder_uintptr_t)kptr +
                        ^

vim +3067 drivers/android/binder.c

  2761	
  2762	static void binder_transaction(struct binder_proc *proc,
  2763				       struct binder_thread *thread,
  2764				       struct binder_transaction_data *tr, int reply,
  2765				       binder_size_t extra_buffers_size)
  2766	{
  2767		int ret;
  2768		struct binder_transaction *t;
  2769		struct binder_work *w;
  2770		struct binder_work *tcomplete;
  2771		binder_size_t *offp, *off_end, *off_start;
  2772		binder_size_t off_min;
  2773		u8 *sg_bufp, *sg_buf_end;
  2774		struct binder_proc *target_proc = NULL;
  2775		struct binder_thread *target_thread = NULL;
  2776		struct binder_node *target_node = NULL;
  2777		struct binder_transaction *in_reply_to = NULL;
  2778		struct binder_transaction_log_entry *e;
  2779		uint32_t return_error = 0;
  2780		uint32_t return_error_param = 0;
  2781		uint32_t return_error_line = 0;
  2782		struct binder_buffer_object *last_fixup_obj = NULL;
  2783		binder_size_t last_fixup_min_off = 0;
  2784		struct binder_context *context = proc->context;
  2785		int t_debug_id = atomic_inc_return(&binder_last_id);
  2786		char *secctx = NULL;
  2787		u32 secctx_sz = 0;
  2788	
  2789		e = binder_transaction_log_add(&binder_transaction_log);
  2790		e->debug_id = t_debug_id;
  2791		e->call_type = reply ? 2 : !!(tr->flags & TF_ONE_WAY);
  2792		e->from_proc = proc->pid;
  2793		e->from_thread = thread->pid;
  2794		e->target_handle = tr->target.handle;
  2795		e->data_size = tr->data_size;
  2796		e->offsets_size = tr->offsets_size;
  2797		e->context_name = proc->context->name;
  2798	
  2799		if (reply) {
  2800			binder_inner_proc_lock(proc);
  2801			in_reply_to = thread->transaction_stack;
  2802			if (in_reply_to == NULL) {
  2803				binder_inner_proc_unlock(proc);
  2804				binder_user_error("%d:%d got reply transaction with no transaction stack\n",
  2805						  proc->pid, thread->pid);
  2806				return_error = BR_FAILED_REPLY;
  2807				return_error_param = -EPROTO;
  2808				return_error_line = __LINE__;
  2809				goto err_empty_call_stack;
  2810			}
  2811			if (in_reply_to->to_thread != thread) {
  2812				spin_lock(&in_reply_to->lock);
  2813				binder_user_error("%d:%d got reply transaction with bad transaction stack, transaction %d has target %d:%d\n",
  2814					proc->pid, thread->pid, in_reply_to->debug_id,
  2815					in_reply_to->to_proc ?
  2816					in_reply_to->to_proc->pid : 0,
  2817					in_reply_to->to_thread ?
  2818					in_reply_to->to_thread->pid : 0);
  2819				spin_unlock(&in_reply_to->lock);
  2820				binder_inner_proc_unlock(proc);
  2821				return_error = BR_FAILED_REPLY;
  2822				return_error_param = -EPROTO;
  2823				return_error_line = __LINE__;
  2824				in_reply_to = NULL;
  2825				goto err_bad_call_stack;
  2826			}
  2827			thread->transaction_stack = in_reply_to->to_parent;
  2828			binder_inner_proc_unlock(proc);
  2829			binder_set_nice(in_reply_to->saved_priority);
  2830			target_thread = binder_get_txn_from_and_acq_inner(in_reply_to);
  2831			if (target_thread == NULL) {
  2832				/* annotation for sparse */
  2833				__release(&target_thread->proc->inner_lock);
  2834				return_error = BR_DEAD_REPLY;
  2835				return_error_line = __LINE__;
  2836				goto err_dead_binder;
  2837			}
  2838			if (target_thread->transaction_stack != in_reply_to) {
  2839				binder_user_error("%d:%d got reply transaction with bad target transaction stack %d, expected %d\n",
  2840					proc->pid, thread->pid,
  2841					target_thread->transaction_stack ?
  2842					target_thread->transaction_stack->debug_id : 0,
  2843					in_reply_to->debug_id);
  2844				binder_inner_proc_unlock(target_thread->proc);
  2845				return_error = BR_FAILED_REPLY;
  2846				return_error_param = -EPROTO;
  2847				return_error_line = __LINE__;
  2848				in_reply_to = NULL;
  2849				target_thread = NULL;
  2850				goto err_dead_binder;
  2851			}
  2852			target_proc = target_thread->proc;
  2853			target_proc->tmp_ref++;
  2854			binder_inner_proc_unlock(target_thread->proc);
  2855		} else {
  2856			if (tr->target.handle) {
  2857				struct binder_ref *ref;
  2858	
  2859				/*
  2860				 * There must already be a strong ref
  2861				 * on this node. If so, do a strong
  2862				 * increment on the node to ensure it
  2863				 * stays alive until the transaction is
  2864				 * done.
  2865				 */
  2866				binder_proc_lock(proc);
  2867				ref = binder_get_ref_olocked(proc, tr->target.handle,
  2868							     true);
  2869				if (ref) {
  2870					target_node = binder_get_node_refs_for_txn(
  2871							ref->node, &target_proc,
  2872							&return_error);
  2873				} else {
  2874					binder_user_error("%d:%d got transaction to invalid handle\n",
  2875							  proc->pid, thread->pid);
  2876					return_error = BR_FAILED_REPLY;
  2877				}
  2878				binder_proc_unlock(proc);
  2879			} else {
  2880				mutex_lock(&context->context_mgr_node_lock);
  2881				target_node = context->binder_context_mgr_node;
  2882				if (target_node)
  2883					target_node = binder_get_node_refs_for_txn(
  2884							target_node, &target_proc,
  2885							&return_error);
  2886				else
  2887					return_error = BR_DEAD_REPLY;
  2888				mutex_unlock(&context->context_mgr_node_lock);
  2889				if (target_node && target_proc == proc) {
  2890					binder_user_error("%d:%d got transaction to context manager from process owning it\n",
  2891							  proc->pid, thread->pid);
  2892					return_error = BR_FAILED_REPLY;
  2893					return_error_param = -EINVAL;
  2894					return_error_line = __LINE__;
  2895					goto err_invalid_target_handle;
  2896				}
  2897			}
  2898			if (!target_node) {
  2899				/*
  2900				 * return_error is set above
  2901				 */
  2902				return_error_param = -EINVAL;
  2903				return_error_line = __LINE__;
  2904				goto err_dead_binder;
  2905			}
  2906			e->to_node = target_node->debug_id;
  2907			if (security_binder_transaction(proc->tsk,
  2908							target_proc->tsk) < 0) {
  2909				return_error = BR_FAILED_REPLY;
  2910				return_error_param = -EPERM;
  2911				return_error_line = __LINE__;
  2912				goto err_invalid_target_handle;
  2913			}
  2914			binder_inner_proc_lock(proc);
  2915	
  2916			w = list_first_entry_or_null(&thread->todo,
  2917						     struct binder_work, entry);
  2918			if (!(tr->flags & TF_ONE_WAY) && w &&
  2919			    w->type == BINDER_WORK_TRANSACTION) {
  2920				/*
  2921				 * Do not allow new outgoing transaction from a
  2922				 * thread that has a transaction at the head of
  2923				 * its todo list. Only need to check the head
  2924				 * because binder_select_thread_ilocked picks a
  2925				 * thread from proc->waiting_threads to enqueue
  2926				 * the transaction, and nothing is queued to the
  2927				 * todo list while the thread is on waiting_threads.
  2928				 */
  2929				binder_user_error("%d:%d new transaction not allowed when there is a transaction on thread todo\n",
  2930						  proc->pid, thread->pid);
  2931				binder_inner_proc_unlock(proc);
  2932				return_error = BR_FAILED_REPLY;
  2933				return_error_param = -EPROTO;
  2934				return_error_line = __LINE__;
  2935				goto err_bad_todo_list;
  2936			}
  2937	
  2938			if (!(tr->flags & TF_ONE_WAY) && thread->transaction_stack) {
  2939				struct binder_transaction *tmp;
  2940	
  2941				tmp = thread->transaction_stack;
  2942				if (tmp->to_thread != thread) {
  2943					spin_lock(&tmp->lock);
  2944					binder_user_error("%d:%d got new transaction with bad transaction stack, transaction %d has target %d:%d\n",
  2945						proc->pid, thread->pid, tmp->debug_id,
  2946						tmp->to_proc ? tmp->to_proc->pid : 0,
  2947						tmp->to_thread ?
  2948						tmp->to_thread->pid : 0);
  2949					spin_unlock(&tmp->lock);
  2950					binder_inner_proc_unlock(proc);
  2951					return_error = BR_FAILED_REPLY;
  2952					return_error_param = -EPROTO;
  2953					return_error_line = __LINE__;
  2954					goto err_bad_call_stack;
  2955				}
  2956				while (tmp) {
  2957					struct binder_thread *from;
  2958	
  2959					spin_lock(&tmp->lock);
  2960					from = tmp->from;
  2961					if (from && from->proc == target_proc) {
  2962						atomic_inc(&from->tmp_ref);
  2963						target_thread = from;
  2964						spin_unlock(&tmp->lock);
  2965						break;
  2966					}
  2967					spin_unlock(&tmp->lock);
  2968					tmp = tmp->from_parent;
  2969				}
  2970			}
  2971			binder_inner_proc_unlock(proc);
  2972		}
  2973		if (target_thread)
  2974			e->to_thread = target_thread->pid;
  2975		e->to_proc = target_proc->pid;
  2976	
  2977		/* TODO: reuse incoming transaction for reply */
  2978		t = kzalloc(sizeof(*t), GFP_KERNEL);
  2979		if (t == NULL) {
  2980			return_error = BR_FAILED_REPLY;
  2981			return_error_param = -ENOMEM;
  2982			return_error_line = __LINE__;
  2983			goto err_alloc_t_failed;
  2984		}
  2985		INIT_LIST_HEAD(&t->fd_fixups);
  2986		binder_stats_created(BINDER_STAT_TRANSACTION);
  2987		spin_lock_init(&t->lock);
  2988	
  2989		tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
  2990		if (tcomplete == NULL) {
  2991			return_error = BR_FAILED_REPLY;
  2992			return_error_param = -ENOMEM;
  2993			return_error_line = __LINE__;
  2994			goto err_alloc_tcomplete_failed;
  2995		}
  2996		binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
  2997	
  2998		t->debug_id = t_debug_id;
  2999	
  3000		if (reply)
  3001			binder_debug(BINDER_DEBUG_TRANSACTION,
  3002				     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
  3003				     proc->pid, thread->pid, t->debug_id,
  3004				     target_proc->pid, target_thread->pid,
  3005				     (u64)tr->data.ptr.buffer,
  3006				     (u64)tr->data.ptr.offsets,
  3007				     (u64)tr->data_size, (u64)tr->offsets_size,
  3008				     (u64)extra_buffers_size);
  3009		else
  3010			binder_debug(BINDER_DEBUG_TRANSACTION,
  3011				     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
  3012				     proc->pid, thread->pid, t->debug_id,
  3013				     target_proc->pid, target_node->debug_id,
  3014				     (u64)tr->data.ptr.buffer,
  3015				     (u64)tr->data.ptr.offsets,
  3016				     (u64)tr->data_size, (u64)tr->offsets_size,
  3017				     (u64)extra_buffers_size);
  3018	
  3019		if (!reply && !(tr->flags & TF_ONE_WAY))
  3020			t->from = thread;
  3021		else
  3022			t->from = NULL;
  3023		t->sender_euid = task_euid(proc->tsk);
  3024		t->to_proc = target_proc;
  3025		t->to_thread = target_thread;
  3026		t->code = tr->code;
  3027		t->flags = tr->flags;
  3028		t->priority = task_nice(current);
  3029	
  3030		if (target_node && target_node->txn_security_ctx) {
  3031			u32 secid;
  3032	
  3033			security_task_getsecid(proc->tsk, &secid);
  3034			ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
  3035			if (ret) {
  3036				return_error = BR_FAILED_REPLY;
  3037				return_error_param = ret;
  3038				return_error_line = __LINE__;
  3039				goto err_get_secctx_failed;
  3040			}
  3041			extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
  3042		}
  3043	
  3044		trace_binder_transaction(reply, t, target_node);
  3045	
  3046		t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
  3047			tr->offsets_size, extra_buffers_size,
  3048			!reply && (t->flags & TF_ONE_WAY));
  3049		if (IS_ERR(t->buffer)) {
  3050			/*
  3051			 * -ESRCH indicates VMA cleared. The target is dying.
  3052			 */
  3053			return_error_param = PTR_ERR(t->buffer);
  3054			return_error = return_error_param == -ESRCH ?
  3055				BR_DEAD_REPLY : BR_FAILED_REPLY;
  3056			return_error_line = __LINE__;
  3057			t->buffer = NULL;
  3058			goto err_binder_alloc_buf_failed;
  3059		}
  3060		if (secctx) {
  3061			size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
  3062					    ALIGN(tr->offsets_size, sizeof(void *)) +
  3063					    ALIGN(extra_buffers_size, sizeof(void *)) -
  3064					    ALIGN(secctx_sz, sizeof(u64));
  3065			char *kptr = t->buffer->data + buf_offset;
  3066	
> 3067			t->security_ctx = (binder_uintptr_t)kptr +
  3068			    binder_alloc_get_user_buffer_offset(&target_proc->alloc);
  3069			memcpy(kptr, secctx, secctx_sz);
  3070			security_release_secctx(secctx, secctx_sz);
  3071			secctx = NULL;
  3072		}
  3073		t->buffer->debug_id = t->debug_id;
  3074		t->buffer->transaction = t;
  3075		t->buffer->target_node = target_node;
  3076		trace_binder_transaction_alloc_buf(t->buffer);
  3077		off_start = (binder_size_t *)(t->buffer->data +
  3078					      ALIGN(tr->data_size, sizeof(void *)));
  3079		offp = off_start;
  3080	
  3081		if (copy_from_user(t->buffer->data, (const void __user *)(uintptr_t)
  3082				   tr->data.ptr.buffer, tr->data_size)) {
  3083			binder_user_error("%d:%d got transaction with invalid data ptr\n",
  3084					proc->pid, thread->pid);
  3085			return_error = BR_FAILED_REPLY;
  3086			return_error_param = -EFAULT;
  3087			return_error_line = __LINE__;
  3088			goto err_copy_data_failed;
  3089		}
  3090		if (copy_from_user(offp, (const void __user *)(uintptr_t)
  3091				   tr->data.ptr.offsets, tr->offsets_size)) {
  3092			binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
  3093					proc->pid, thread->pid);
  3094			return_error = BR_FAILED_REPLY;
  3095			return_error_param = -EFAULT;
  3096			return_error_line = __LINE__;
  3097			goto err_copy_data_failed;
  3098		}
  3099		if (!IS_ALIGNED(tr->offsets_size, sizeof(binder_size_t))) {
  3100			binder_user_error("%d:%d got transaction with invalid offsets size, %lld\n",
  3101					proc->pid, thread->pid, (u64)tr->offsets_size);
  3102			return_error = BR_FAILED_REPLY;
  3103			return_error_param = -EINVAL;
  3104			return_error_line = __LINE__;
  3105			goto err_bad_offset;
  3106		}
  3107		if (!IS_ALIGNED(extra_buffers_size, sizeof(u64))) {
  3108			binder_user_error("%d:%d got transaction with unaligned buffers size, %lld\n",
  3109					  proc->pid, thread->pid,
  3110					  (u64)extra_buffers_size);
  3111			return_error = BR_FAILED_REPLY;
  3112			return_error_param = -EINVAL;
  3113			return_error_line = __LINE__;
  3114			goto err_bad_offset;
  3115		}
  3116		off_end = (void *)off_start + tr->offsets_size;
  3117		sg_bufp = (u8 *)(PTR_ALIGN(off_end, sizeof(void *)));
  3118		sg_buf_end = sg_bufp + extra_buffers_size;
  3119		off_min = 0;
  3120		for (; offp < off_end; offp++) {
  3121			struct binder_object_header *hdr;
  3122			size_t object_size = binder_validate_object(t->buffer, *offp);
  3123	
  3124			if (object_size == 0 || *offp < off_min) {
  3125				binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
  3126						  proc->pid, thread->pid, (u64)*offp,
  3127						  (u64)off_min,
  3128						  (u64)t->buffer->data_size);
  3129				return_error = BR_FAILED_REPLY;
  3130				return_error_param = -EINVAL;
  3131				return_error_line = __LINE__;
  3132				goto err_bad_offset;
  3133			}
  3134	
  3135			hdr = (struct binder_object_header *)(t->buffer->data + *offp);
  3136			off_min = *offp + object_size;
  3137			switch (hdr->type) {
  3138			case BINDER_TYPE_BINDER:
  3139			case BINDER_TYPE_WEAK_BINDER: {
  3140				struct flat_binder_object *fp;
  3141	
  3142				fp = to_flat_binder_object(hdr);
  3143				ret = binder_translate_binder(fp, t, thread);
  3144				if (ret < 0) {
  3145					return_error = BR_FAILED_REPLY;
  3146					return_error_param = ret;
  3147					return_error_line = __LINE__;
  3148					goto err_translate_failed;
  3149				}
  3150			} break;
  3151			case BINDER_TYPE_HANDLE:
  3152			case BINDER_TYPE_WEAK_HANDLE: {
  3153				struct flat_binder_object *fp;
  3154	
  3155				fp = to_flat_binder_object(hdr);
  3156				ret = binder_translate_handle(fp, t, thread);
  3157				if (ret < 0) {
  3158					return_error = BR_FAILED_REPLY;
  3159					return_error_param = ret;
  3160					return_error_line = __LINE__;
  3161					goto err_translate_failed;
  3162				}
  3163			} break;
  3164	
  3165			case BINDER_TYPE_FD: {
  3166				struct binder_fd_object *fp = to_binder_fd_object(hdr);
  3167				int ret = binder_translate_fd(&fp->fd, t, thread,
  3168							      in_reply_to);
  3169	
  3170				if (ret < 0) {
  3171					return_error = BR_FAILED_REPLY;
  3172					return_error_param = ret;
  3173					return_error_line = __LINE__;
  3174					goto err_translate_failed;
  3175				}
  3176				fp->pad_binder = 0;
  3177			} break;
  3178			case BINDER_TYPE_FDA: {
  3179				struct binder_fd_array_object *fda =
  3180					to_binder_fd_array_object(hdr);
  3181				struct binder_buffer_object *parent =
  3182					binder_validate_ptr(t->buffer, fda->parent,
  3183							    off_start,
  3184							    offp - off_start);
  3185				if (!parent) {
  3186					binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
  3187							  proc->pid, thread->pid);
  3188					return_error = BR_FAILED_REPLY;
  3189					return_error_param = -EINVAL;
  3190					return_error_line = __LINE__;
  3191					goto err_bad_parent;
  3192				}
  3193				if (!binder_validate_fixup(t->buffer, off_start,
  3194							   parent, fda->parent_offset,
  3195							   last_fixup_obj,
  3196							   last_fixup_min_off)) {
  3197					binder_user_error("%d:%d got transaction with out-of-order buffer fixup\n",
  3198							  proc->pid, thread->pid);
  3199					return_error = BR_FAILED_REPLY;
  3200					return_error_param = -EINVAL;
  3201					return_error_line = __LINE__;
  3202					goto err_bad_parent;
  3203				}
  3204				ret = binder_translate_fd_array(fda, parent, t, thread,
  3205								in_reply_to);
  3206				if (ret < 0) {
  3207					return_error = BR_FAILED_REPLY;
  3208					return_error_param = ret;
  3209					return_error_line = __LINE__;
  3210					goto err_translate_failed;
  3211				}
  3212				last_fixup_obj = parent;
  3213				last_fixup_min_off =
  3214					fda->parent_offset + sizeof(u32) * fda->num_fds;
  3215			} break;
  3216			case BINDER_TYPE_PTR: {
  3217				struct binder_buffer_object *bp =
  3218					to_binder_buffer_object(hdr);
  3219				size_t buf_left = sg_buf_end - sg_bufp;
  3220	
  3221				if (bp->length > buf_left) {
  3222					binder_user_error("%d:%d got transaction with too large buffer\n",
  3223							  proc->pid, thread->pid);
  3224					return_error = BR_FAILED_REPLY;
  3225					return_error_param = -EINVAL;
  3226					return_error_line = __LINE__;
  3227					goto err_bad_offset;
  3228				}
  3229				if (copy_from_user(sg_bufp,
  3230						   (const void __user *)(uintptr_t)
  3231						   bp->buffer, bp->length)) {
  3232					binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
  3233							  proc->pid, thread->pid);
  3234					return_error_param = -EFAULT;
  3235					return_error = BR_FAILED_REPLY;
  3236					return_error_line = __LINE__;
  3237					goto err_copy_data_failed;
  3238				}
  3239				/* Fixup buffer pointer to target proc address space */
  3240				bp->buffer = (uintptr_t)sg_bufp +
  3241					binder_alloc_get_user_buffer_offset(
  3242							&target_proc->alloc);
  3243				sg_bufp += ALIGN(bp->length, sizeof(u64));
  3244	
  3245				ret = binder_fixup_parent(t, thread, bp, off_start,
  3246							  offp - off_start,
  3247							  last_fixup_obj,
  3248							  last_fixup_min_off);
  3249				if (ret < 0) {
  3250					return_error = BR_FAILED_REPLY;
  3251					return_error_param = ret;
  3252					return_error_line = __LINE__;
  3253					goto err_translate_failed;
  3254				}
  3255				last_fixup_obj = bp;
  3256				last_fixup_min_off = 0;
  3257			} break;
  3258			default:
  3259				binder_user_error("%d:%d got transaction with invalid object type, %x\n",
  3260					proc->pid, thread->pid, hdr->type);
  3261				return_error = BR_FAILED_REPLY;
  3262				return_error_param = -EINVAL;
  3263				return_error_line = __LINE__;
  3264				goto err_bad_object_type;
  3265			}
  3266		}
  3267		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
  3268		t->work.type = BINDER_WORK_TRANSACTION;
  3269	
  3270		if (reply) {
  3271			binder_enqueue_thread_work(thread, tcomplete);
  3272			binder_inner_proc_lock(target_proc);
  3273			if (target_thread->is_dead) {
  3274				binder_inner_proc_unlock(target_proc);
  3275				goto err_dead_proc_or_thread;
  3276			}
  3277			BUG_ON(t->buffer->async_transaction != 0);
  3278			binder_pop_transaction_ilocked(target_thread, in_reply_to);
  3279			binder_enqueue_thread_work_ilocked(target_thread, &t->work);
  3280			binder_inner_proc_unlock(target_proc);
  3281			wake_up_interruptible_sync(&target_thread->wait);
  3282			binder_free_transaction(in_reply_to);
  3283		} else if (!(t->flags & TF_ONE_WAY)) {
  3284			BUG_ON(t->buffer->async_transaction != 0);
  3285			binder_inner_proc_lock(proc);
  3286			/*
  3287			 * Defer the TRANSACTION_COMPLETE, so we don't return to
  3288			 * userspace immediately; this allows the target process to
  3289			 * immediately start processing this transaction, reducing
  3290			 * latency. We will then return the TRANSACTION_COMPLETE when
  3291			 * the target replies (or there is an error).
  3292			 */
  3293			binder_enqueue_deferred_thread_work_ilocked(thread, tcomplete);
  3294			t->need_reply = 1;
  3295			t->from_parent = thread->transaction_stack;
  3296			thread->transaction_stack = t;
  3297			binder_inner_proc_unlock(proc);
  3298			if (!binder_proc_transaction(t, target_proc, target_thread)) {
  3299				binder_inner_proc_lock(proc);
  3300				binder_pop_transaction_ilocked(thread, t);
  3301				binder_inner_proc_unlock(proc);
  3302				goto err_dead_proc_or_thread;
  3303			}
  3304		} else {
  3305			BUG_ON(target_node == NULL);
  3306			BUG_ON(t->buffer->async_transaction != 1);
  3307			binder_enqueue_thread_work(thread, tcomplete);
  3308			if (!binder_proc_transaction(t, target_proc, NULL))
  3309				goto err_dead_proc_or_thread;
  3310		}
  3311		if (target_thread)
  3312			binder_thread_dec_tmpref(target_thread);
  3313		binder_proc_dec_tmpref(target_proc);
  3314		if (target_node)
  3315			binder_dec_node_tmpref(target_node);
  3316		/*
  3317		 * write barrier to synchronize with initialization
  3318		 * of log entry
  3319		 */
  3320		smp_wmb();
  3321		WRITE_ONCE(e->debug_id_done, t_debug_id);
  3322		return;
  3323	
  3324	err_dead_proc_or_thread:
  3325		return_error = BR_DEAD_REPLY;
  3326		return_error_line = __LINE__;
  3327		binder_dequeue_work(proc, tcomplete);
  3328	err_translate_failed:
  3329	err_bad_object_type:
  3330	err_bad_offset:
  3331	err_bad_parent:
  3332	err_copy_data_failed:
  3333		binder_free_txn_fixups(t);
  3334		trace_binder_transaction_failed_buffer_release(t->buffer);
  3335		binder_transaction_buffer_release(target_proc, t->buffer, offp);
  3336		if (target_node)
  3337			binder_dec_node_tmpref(target_node);
  3338		target_node = NULL;
  3339		t->buffer->transaction = NULL;
  3340		binder_alloc_free_buf(&target_proc->alloc, t->buffer);
  3341	err_binder_alloc_buf_failed:
  3342		if (secctx)
  3343			security_release_secctx(secctx, secctx_sz);
  3344	err_get_secctx_failed:
  3345		kfree(tcomplete);
  3346		binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
  3347	err_alloc_tcomplete_failed:
  3348		kfree(t);
  3349		binder_stats_deleted(BINDER_STAT_TRANSACTION);
  3350	err_alloc_t_failed:
  3351	err_bad_todo_list:
  3352	err_bad_call_stack:
  3353	err_empty_call_stack:
  3354	err_dead_binder:
  3355	err_invalid_target_handle:
  3356		if (target_thread)
  3357			binder_thread_dec_tmpref(target_thread);
  3358		if (target_proc)
  3359			binder_proc_dec_tmpref(target_proc);
  3360		if (target_node) {
  3361			binder_dec_node(target_node, 1, 0);
  3362			binder_dec_node_tmpref(target_node);
  3363		}
  3364	
  3365		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
  3366			     "%d:%d transaction failed %d/%d, size %lld-%lld line %d\n",
  3367			     proc->pid, thread->pid, return_error, return_error_param,
  3368			     (u64)tr->data_size, (u64)tr->offsets_size,
  3369			     return_error_line);
  3370	
  3371		{
  3372			struct binder_transaction_log_entry *fe;
  3373	
  3374			e->return_error = return_error;
  3375			e->return_error_param = return_error_param;
  3376			e->return_error_line = return_error_line;
  3377			fe = binder_transaction_log_add(&binder_transaction_log_failed);
  3378			*fe = *e;
  3379			/*
  3380			 * write barrier to synchronize with initialization
  3381			 * of log entry
  3382			 */
  3383			smp_wmb();
  3384			WRITE_ONCE(e->debug_id_done, t_debug_id);
  3385			WRITE_ONCE(fe->debug_id_done, t_debug_id);
  3386		}
  3387	
  3388		BUG_ON(thread->return_error.cmd != BR_OK);
  3389		if (in_reply_to) {
  3390			thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
  3391			binder_enqueue_thread_work(thread, &thread->return_error.work);
  3392			binder_send_failed_reply(in_reply_to, return_error);
  3393		} else {
  3394			thread->return_error.cmd = return_error;
  3395			binder_enqueue_thread_work(thread, &thread->return_error.work);
  3396		}
  3397	}
  3398	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2oS5YaxWCcQjTEyO--
