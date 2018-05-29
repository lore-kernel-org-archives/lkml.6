Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934944AbeE2OZC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935257AbeE2OYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:24:38 -0400
X-Google-Smtp-Source: ADUXVKJnVADeXbSLQk0Qe76Mvgbcnay7NN7rAM5M/TexzzoQjNZPc7dXZvz4LBqneCH6/PvhuWV6lQA1EHELbXHHw+M=
MIME-Version: 1.0
In-Reply-To: <20180529094204.3945660-1-arnd@arndb.de>
References: <20180529094204.3945660-1-arnd@arndb.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 09:24:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKf0nyw0yvw=4brGRvMHgZrrt+nJnBs5KWATcfijhiyug@mail.gmail.com>
Message-ID: <CAL_JsqKf0nyw0yvw=4brGRvMHgZrrt+nJnBs5KWATcfijhiyug@mail.gmail.com>
Subject: Re: [PATCH] pci: mvebu: add MVEBU_MBUS dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Enabling the PCI_MVEBU driver for compile testing caused a build failure
> on ARM randconfig builds:
>
> drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_del_windows':
> drivers/pci/host/pci-mvebu.c:341:3: error: implicit declaration of function 'mvebu_mbus_del_window'; did you mean 'mvebu_pcie_del_windows'? [-Werror=implicit-function-declaration]
>    mvebu_mbus_del_window(base, sz);
>    ^~~~~~~~~~~~~~~~~~~~~
>    mvebu_pcie_del_windows
> drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_add_windows':
> drivers/pci/host/pci-mvebu.c:364:9: error: implicit declaration of function 'mvebu_mbus_add_window_remap_by_id'; did you mean 'mvebu_pcie_add_windows'? [-Werror=implicit-function-declaration]
>    ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          mvebu_pcie_add_windows
> drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_probe':
> drivers/pci/host/pci-mvebu.c:1209:2: error: implicit declaration of function 'mvebu_mbus_get_pcie_mem_aperture'; did you mean 'mvebu_mbus_get_io_win_info'? [-Werror=implicit-function-declaration]
> drivers/pci/host/pci-mvebu.c:1215:2: error: implicit declaration of function 'mvebu_mbus_get_pcie_io_aperture'; did you mean 'mvebu_mbus_get_io_win_info'? [-Werror=implicit-function-declaration]
>
> The problem is that the mbus helper functions are not declared in the
> header. There are two ways of solving this: we can change the header
> to provide empty stub functions for CONFIG_MVEBU_MBUS=n, or we can
> add back the dependency here.

Probably better to just make these non-standard dependencies explicit.

> I picked the second option since that is simpler, but it somewhat
> defeats the purpose of the original patch because we still cannot
> compile test on other platforms this way.
>
> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Rob Herring <robh@kernel.org>
