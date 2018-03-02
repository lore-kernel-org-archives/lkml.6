Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165131AbeCBMfa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:35:30 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:38424 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164824AbeCBMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:35:28 -0500
X-Google-Smtp-Source: AG47ELsBcCuWk5EQ9nA1v+LuUml1xnxoseu3PTE84eSzPoPjq7gswwMjnNbsaX2QjLGnIhrr0SWDloKSFKtEjPa8czs=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CnePJqXnb_14FaWxjx0AC4oT0m_SqFtwPjwjskquSYPw@mail.gmail.com>
References: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
 <20180301182436.GI12864@sirena.org.uk> <CAOMZO5CnePJqXnb_14FaWxjx0AC4oT0m_SqFtwPjwjskquSYPw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Mar 2018 09:35:27 -0300
Message-ID: <CAOMZO5Bad2OkWhxFrQax+V4_DrtajwjisMe3O39WfCU3qGd5zg@mail.gmail.com>
Subject: Re: regmap: Failed to create debugfs directory
To: Mark Brown <broonie@kernel.org>
Cc: brgl@bgdev.pl, David Lechner <david@lechnology.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Mar 1, 2018 at 9:27 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Mark,
>
> On Thu, Mar 1, 2018 at 3:24 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> Is this triggered by 9b947a13e7f6017f18 (regmap: use debugfs even when
>> no device)?
>
> Yes, exactly. If I revert this commit the warnings are gone.
>
> Should I send a revert or is there another way to solve it?

Does the change below look good?

diff --git a/drivers/base/regmap/regmap-debugfs.c
b/drivers/base/regmap/regmap-debugfs.c
index 7eb512b..018d3a2 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -575,7 +575,8 @@ void regmap_debugfs_init(struct regmap *map, const
char *name)

        map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
        if (!map->debugfs) {
-               dev_warn(map->dev, "Failed to create debugfs directory\n");
+               if (map->dev)
+                       dev_warn(map->dev, "Failed to create debugfs
directory\n");
                return;
        }
