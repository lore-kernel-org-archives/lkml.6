Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0CF2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oHss5UCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeLOJit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:38:49 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18725 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:38:48 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBF9cQYB008452;
        Sat, 15 Dec 2018 18:38:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBF9cQYB008452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544866707;
        bh=c3rKRXWxtwSQ9KtyVVkel0TbvEqzIGhF6c8ZIY1ZZrU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oHss5UCRRgdNJoouSqjk8deSLH/UayiTbUImM1xz+QPeomnSe00567zD/LctIY0vs
         WWMo+jXaJLoTDYHlYtbkejFlkqvTv09U0I3gGMWQwnzVK1rjJLdRulunUXURH20csj
         Tmzcp0JH56ofqazn0mWS/PPZ8JrsTbu4baHLdQOltHxETHRMdS2CWHd4W/OPGbOTzK
         MS8QMKQqtsH4TK36ccyGgm796pTqRu64R6x0W02GXJ7HzFXSg+yuk0Jsd9BVLUQf9O
         6lsbfoGih9kytniOPEXoDudx9VQQhQi4virVYoBmBsib6MbHLTuxPcfJej7SuFSMjq
         fTgA7mFZqicEg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id x64so4895052vsa.5;
        Sat, 15 Dec 2018 01:38:26 -0800 (PST)
X-Gm-Message-State: AA+aEWY7SIDVGOdqg36rBYH/NqUfm8GSvClD1YrHR6Tl42D2RAQWrQMx
        8mcw72Ub/objPJDb0plQBC8EDH+S6KZCsb4cRcM=
X-Google-Smtp-Source: AFSGD/XGG9VbGe70bdKLjTsanf3MZnKRHJpd+TirgVzzkCcG+F0ugnf6rePRvK19j9nDRgMAKXYZ8B8xFpEVvC8wt+Y=
X-Received: by 2002:a67:485:: with SMTP id 127mr2949918vse.54.1544866705872;
 Sat, 15 Dec 2018 01:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20181206222318.218157-1-tmroeder@google.com>
In-Reply-To: <20181206222318.218157-1-tmroeder@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 15 Dec 2018 18:37:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
Message-ID: <CAK7LNATZm6T9bjcAxB_WQw-um-Hjkhiew6qg8CRLayr8qYzLeQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: add a tool to produce a compile_commands.json file
To:     Tom Roeder <tmroeder@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 7:24 AM Tom Roeder <tmroeder@google.com> wrote:
>
> The LLVM/Clang project provides many tools for analyzing C source code.
> Many of these tools are based on LibTooling
> (https://clang.llvm.org/docs/LibTooling.html), which depends on a
> database of compiler flags. The standard container for this database is
> compile_commands.json, which consists of a list of JSON objects, each
> with "directory", "file", and "command" fields.
>
> Some build systems, like cmake or bazel, produce this compilation
> information directly. Naturally, Makefiles don't. However, the kernel
> makefiles already create .<target>.o.cmd files that contain all the
> information needed to build a compile_commands.json file.
>
> So, this commit adds scripts/gen_compile_commands.py, which recursively
> searches through a directory for .<target>.o.cmd files and extracts
> appropriate compile commands from them. It writes a
> compile_commands.json file that LibTooling-based tools can use.
>
> By default, gen_compile_commands.py starts its search in its working
> directory and (over)writes compile_commands.json in the working
> directory. However, it also supports --output and --directory flags for
> out-of-tree use.
>
> Note that while gen_compile_commands.py enables the use of clang-based
> tools, it does not require the kernel to be compiled with clang. E.g.,
> the following sequence of commands produces a compile_commands.json file
> that works correctly with LibTooling.
>
> make defconfig
> make
> scripts/gen_compile_commands.py
>
> Also note that this script is written to work correctly in both Python 2
> and Python 3, so it does not specify the Python version in its first
> line.
>
> For an example of the utility of this script: after running
> gen_compile_commands.json on the latest kernel version, I was able to
> use Vim + the YouCompleteMe pluging + clangd to automatically jump to
> definitions and declarations. Obviously, cscope and ctags provide some
> of this functionality; the advantage of supporting LibTooling is that it
> opens the door to many other clang-based tools that understand the code
> directly and do not rely on regular expressions and heuristics.
>
> Tested: Built several recent kernel versions and ran the script against
> them, testing tools like clangd (for editor/LSP support) and clang-check
> (for static analysis). Also extracted some test .cmd files from a kernel
> build and wrote a test script to check that the script behaved correctly
> with all permutations of the --output and --directory flags.
>
> Signed-off-by: Tom Roeder <tmroeder@google.com>


I am fine with this,
but I have one question.

The generated compile_commands.json
contains $(pound)

How is it handled?
Should it be replaced with '\#' ?





-- 
Best Regards
Masahiro Yamada
