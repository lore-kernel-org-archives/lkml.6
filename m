Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7758C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C90218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UZtj27ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeLSOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:45:49 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40671 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeLSOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:45:48 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBJEjg99001953;
        Wed, 19 Dec 2018 23:45:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBJEjg99001953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545230743;
        bh=vmrhOZSbXQRZKTgtfY4HSigGcDt4V1IH8thrZfvjEgc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UZtj27ZVmH3tjnKxJ1bq/gLq+blKT7hAVGFDKKVk0goBMd4I085nGLMXtK6AwcNBz
         6amWMzDnBzhdxylFKWvHAfAj2pSfidtweuGJOkh8DwYpTo8FV2XLehvaPjwdWYQYI/
         AD0YBD8WGoVF1xi4Kfr5yMI29YqXHNQcCT/nwY9dQiy+aNz6uO2azXoLn1oPck28ek
         kRuk8RtLpnLM2b7qiRV4xr4W+PU+lcgi/0LGayVclncoqyPKVyWcHCQUjZg/A6wwhy
         hUArAkd6PF2KtTOpcd1Hjb0pHrTjL8euvQcPoVNzfhZbOm9N4OVjyFJcTGMo7/ymEp
         gLmqXPryQIPBA==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id x1so12357660vsc.10;
        Wed, 19 Dec 2018 06:45:43 -0800 (PST)
X-Gm-Message-State: AA+aEWY4MV/y50WQ9QgowZNdhJ9c5L8j0udxSXkkKqO0+icvPql8hPtx
        OAl6jTgsn13taTdDzpl3z/5Cm/7H91ffU4UdpEc=
X-Google-Smtp-Source: AFSGD/Wxgw7uJ9H8HnunVaYr+7ZFLJvyzAistOZPRZqi8ehPiRKuFLWEfOfyirvlHVjh80v22kjbztZxtPXVv5nEyO8=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr3539333vsm.181.1545230741896;
 Wed, 19 Dec 2018 06:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20181218224907.1274-1-tmroeder@google.com>
In-Reply-To: <20181218224907.1274-1-tmroeder@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Dec 2018 23:45:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3iZ0P_ttL4CTwZX7dhzeGB4oJ6wyXVwMtaaMovi2_XQ@mail.gmail.com>
Message-ID: <CAK7LNAR3iZ0P_ttL4CTwZX7dhzeGB4oJ6wyXVwMtaaMovi2_XQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: add a tool to produce a compile_commands.json file
To:     Tom Roeder <tmroeder@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 8:40 AM Tom Roeder <tmroeder@google.com> wrote:
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
> ---
> Changelog since v1:
> - Add simple string replacement to unescape the pound sign.


Applied to linux-kbuild. Thanks!


-- 
Best Regards
Masahiro Yamada
