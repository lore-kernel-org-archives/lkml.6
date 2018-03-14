Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeCNSpQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:45:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54013 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:45:15 -0400
X-Google-Smtp-Source: AG47ELsiVxDU0tOvIUYZCPhrlIelwBsqZnxMNZzq7EQwfSu7yuJkfJ3QTpb84vhPolIyKAGDJiGgTvVDe403us99bvA=
MIME-Version: 1.0
In-Reply-To: <20180314092205.23291-1-jolsa@kernel.org>
References: <20180314092205.23291-1-jolsa@kernel.org>
From: Stephane Eranian <eranian@google.com>
Date: Wed, 14 Mar 2018 11:45:14 -0700
Message-ID: <CABPqkBS5u6Qkbw3qoq4ocgsMZSoVF2m_5pBQ5YTRnx3=mZG6LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf record: Synthesize features before events in
 pipe mode
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 2:22 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> We need to synthesize events first, because some
> features works on top of them (on report side).
>
> Link: http://lkml.kernel.org/n/tip-vz436m6fobfz8ykmuxo8phyy@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Works for me.
Tested-by: Stephane Eranian <eranian@google.com>

> ---
>  tools/perf/builtin-record.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d33103291b02..22ebeb92ac51 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -754,13 +754,10 @@ static int record__synthesize(struct record *rec, bool tail)
>                 return 0;
>
>         if (data->is_pipe) {
> -               err = perf_event__synthesize_features(
> -                       tool, session, rec->evlist, process_synthesized_event);
> -               if (err < 0) {
> -                       pr_err("Couldn't synthesize features.\n");
> -                       return err;
> -               }
> -
> +               /*
> +                * We need to synthesize events first, because some
> +                * features works on top of them (on report side).
> +                */
>                 err = perf_event__synthesize_attrs(tool, session,
>                                                    process_synthesized_event);
>                 if (err < 0) {
> @@ -768,6 +765,13 @@ static int record__synthesize(struct record *rec, bool tail)
>                         goto out;
>                 }
>
> +               err = perf_event__synthesize_features(tool, session, rec->evlist,
> +                                                     process_synthesized_event);
> +               if (err < 0) {
> +                       pr_err("Couldn't synthesize features.\n");
> +                       return err;
> +               }
> +
>                 if (have_tracepoints(&rec->evlist->entries)) {
>                         /*
>                          * FIXME err <= 0 here actually means that
> --
> 2.13.6
>
