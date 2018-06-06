Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReJ9Ncl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00F8D601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeFFPzU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:55:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40537 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeFFPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:55:18 -0400
X-Google-Smtp-Source: ADUXVKJ1tb62nz5NtphpgbyBP+HTg7VRFoS7kyQXVq0pSktZb4ivosCgfdpKqc/9eHx1hg/hcSYZhA==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mremap: Increase LATENCY_LIMIT of mremap to reduce the
 number of TLB shootdowns
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180606140255.br5ztpeqdmwfto47@techsingularity.net>
Date: Wed, 6 Jun 2018 08:55:15 -0700
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, mhocko@kernel.org,
        vbabka@suse.cz, Aaron Lu <aaron.lu@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C86F5DE4-DAAE-4C12-B509-E5807ADA471E@gmail.com>
References: <20180606140255.br5ztpeqdmwfto47@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> wrote:

> Commit 5d1904204c99 ("mremap: fix race between mremap() and page =
cleanning")
> fixed races between mremap and other operations for both file-backed =
and
> anonymous mappings. The file-backed was the most critical as it =
allowed the
> possibility that data could be changed on a physical page after =
page_mkclean
> returned which could trigger data loss or data integrity issues. A =
customer
> reported that the cost of the TLBs for anonymous regressions was =
excessive
> and resulting in a 30-50% drop in performance overall since this =
commit
> on a microbenchmark. Unfortunately I neither have access to the =
test-case
> nor can I describe what it does other than saying that mremap =
operations
> dominate heavily.
>=20
> This patch increases the LATENCY_LIMIT to handle TLB flushes on a
> PMD boundary instead of every 64 pages. This reduces the number of TLB
> shootdowns by a factor of 8 which is not reported to completely =
restore
> performance but gets it within an acceptable percentage. The given =
metric
> here is simply described as "higher is better".
>=20
> Baseline that was known good
> 002:  Metric:       91.05
> 004:  Metric:      109.45
> 008:  Metric:       73.08
> 016:  Metric:       58.14
> 032:  Metric:       61.09
> 064:  Metric:       57.76
> 128:  Metric:       55.43
>=20
> Current
> 001:  Metric:       54.98
> 002:  Metric:       56.56
> 004:  Metric:       41.22
> 008:  Metric:       35.96
> 016:  Metric:       36.45
> 032:  Metric:       35.71
> 064:  Metric:       35.73
> 128:  Metric:       34.96
>=20
> With patch
> 001:  Metric:       61.43
> 002:  Metric:       81.64
> 004:  Metric:       67.92
> 008:  Metric:       51.67
> 016:  Metric:       50.47
> 032:  Metric:       52.29
> 064:  Metric:       50.01
> 128:  Metric:       49.04
>=20
> So for low threads, it's not restored but for larger number of =
threads,
> it's closer to the "known good" baseline. The downside is that PTL =
lock
> hold times will be slightly higher but it's unlikely that an mremap =
and
> another operation will contend on the same PMD. This is the first time =
I
> encountered a realistic workload that was mremap intensive (thousands =
of
> calls per second with small ranges dominating).
>=20
> Using a different mremap-intensive workload that is not representative =
of
> the real workload there is little difference observed outside of noise =
in
> the headline metrics However, the TLB shootdowns are reduced by 11% on
> average and at the peak, TLB shootdowns were reduced by 21%. =
Interrupts
> were sampled every second while the workload ran to get those figures.
> It's known that the figures will vary as the non-representative load =
is
> non-deterministic.
>=20
> An alternative patch was posted that should have significantly reduced =
the
> TLB flushes but unfortunately it does not perform as well as this =
version
> on the customer test case. If revisited, the two patches can stack on =
top
> of each other.
>=20
> Signed-off-by: Mel Gorman <mgorman@suse.com>
> ---
> mm/mremap.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 049470aa1e3e..b5017cb2e1e9 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,7 +191,7 @@ static void move_ptes(struct vm_area_struct *vma, =
pmd_t *old_pmd,
> 		drop_rmap_locks(vma);
> }
>=20
> -#define LATENCY_LIMIT	(64 * PAGE_SIZE)
> +#define LATENCY_LIMIT	(PMD_SIZE)
>=20
> unsigned long move_page_tables(struct vm_area_struct *vma,
> 		unsigned long old_addr, struct vm_area_struct *new_vma,

This LATENCY_LIMIT is only used in move_page_tables() in the following
manner:

  next =3D (new_addr + PMD_SIZE) & PMD_MASK;
  if (extent > next - new_addr)
      extent =3D next - new_addr;
  if (extent > LATENCY_LIMIT)
      extent =3D LATENCY_LIMIT;
  =20
If LATENCY_LIMIT is to be changed to PMD_SIZE, then IIUC the last =
condition
is not required, and LATENCY_LIMIT can just be removed (assuming there =
is no
underflow case that hides somewhere).

No?
