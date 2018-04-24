Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDXQPx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:15:53 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48148 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDXQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:15:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
Date: Tue, 24 Apr 2018 11:14:24 -0500
In-Reply-To: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:36 -0400")
Message-ID: <8736zkd1jz.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB0bd-00041h-Ag;;;mid=<8736zkd1jz.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++h1tAL8Jn6P51YW9m9RVClvHL8c/sq5E=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <andrey.grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 180 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.3%), b_tie_ro: 1.62 (0.9%), parse: 0.72 (0.4%),
        extract_message_metadata: 10 (5.4%), get_uri_detail_list: 1.18 (0.7%),
        tests_pri_-1000: 6 (3.1%), tests_pri_-950: 1.14 (0.6%), tests_pri_-900: 0.95
        (0.5%), tests_pri_-400: 18 (9.9%), check_bayes: 17 (9.3%), b_tokenize: 6
        (3.1%), b_tok_get_all: 5 (3.0%), b_comp_prob: 1.65 (0.9%), b_tok_touch_all:
        2.5 (1.4%), b_finish: 0.50 (0.3%), tests_pri_0: 135 (75.2%),
        check_dkim_signature: 0.45 (0.3%), check_dkim_adsp: 2.7 (1.5%),
        tests_pri_500: 3.7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> If the ring is hanging for some reason allow to recover the waiting
> by sending fatal signal.
>
> Originally-by: David Panariti <David.Panariti@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eb80edf..37a36af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>  
>  	if (other) {
>  		signed long r;
> -		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
> -		if (r < 0) {
> -			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> -			return r;
> +
> +		while (true) {
> +			if ((r = dma_fence_wait_timeout(other, true,
> +					MAX_SCHEDULE_TIMEOUT)) >= 0)
> +				return 0;
> +
> +			if (fatal_signal_pending(current)) {
> +				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> +				return r;
> +			}

It looks like if you make this code say:
			if (fatal_signal_pending(current) ||
			    (current->flags & PF_EXITING)) {
				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
				return r;
>  		}
>  	}

Than you would not need the horrible hack want_signal to deliver signals
to processes who have passed exit_signal() and don't expect to need
their signal handling mechanisms anymore.

Eric
