Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422884AbeCBIXF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:23:05 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:35017 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422781AbeCBIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:22:58 -0500
X-Google-Smtp-Source: AG47ELuPcYK4+5WsjDDEXEd1qwrh/fwAun3idAiQCOuBbXk1KTSe+nKP3tN+yOTcDmeeCfCqFTK7xjOOe5CRVuCYlPA=
MIME-Version: 1.0
In-Reply-To: <20180301233724.20440-2-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk> <20180301233724.20440-2-linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri, 2 Mar 2018 09:22:57 +0100
Message-ID: <CAKwiHFguCbT_0i3XWen-c58vzNNPESij9jO8Ou3PdK=_N4kYfA@mail.gmail.com>
Subject: Re: [RFC 2/5] ia64/sn/hwperf: use seq_open_data
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2018 at 00:37, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> This code should check the return value of seq_open(); if it failed,
> file->private_data is NULL. But we can avoid the issue entirely and
> simplify the code by letting seq_open_data() set the ->private member
> to objbuf.
>
>         if ((e = sn_hwperf_enum_objects(&nobj, &objbuf)) == 0) {
> -               e = seq_open(file, &sn_topology_seq_ops);
> -               seq = file->private_data;
> -               seq->private = objbuf;
> +               e = seq_open_data(file, &sn_topology_seq_ops, objbuf);
>         }

Well, this turns a NULL deref into a resource leak; we still need to
add a check of the return value and vfree(objbuf) on failure.

Rasmus
