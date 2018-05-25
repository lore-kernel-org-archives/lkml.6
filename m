Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966134AbeEYKmN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:42:13 -0400
Received: from mail05-md.ns.itscom.net ([175.177.155.115]:60656 "EHLO
        mail05-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965731AbeEYKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:42:12 -0400
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: Why is the length of max mount option a page size??
To: Jungsub Shin <supsup5642@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180521173959.GA12779@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox>
Date: Fri, 25 May 2018 19:42:10 +0900
Message-ID: <5670.1527244930@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jungsub Shin:
> I know that almost mount option short and page size is enough to
> contain almost mount options. but because of options for 
> unionfs(overlay, aufs), lenght of mount option could be exceed it
> and cut.
>
> I suffer this problem with aufs. aufs's branch option is cut and 
> fail to aufs mount. I know that aufs is not offical fs in linux, 

For aufs, it should not happen because of the module parameter 'brs.'

(from the aufs manual)
----------------------------------------------------------------------
.SH Module Parameters
.TP
.B brs=1 | 0
Specifies to use the branch path data file under sysfs or not.

If the number of your branches is large or their path is long
and you meet the limitation of mount(8) ro /etc/mtab, you need to
enable CONFIG_SYSFS and set aufs module parameter brs=1.

When this parameter is set as 1, aufs does not show `br:' (or dirs=)
mount option through /proc/mounts (and /etc/mtab). So you can
keep yourself from the page limitation of
mount(8) or /etc/mtab.
Aufs shows branch paths through <sysfs>/fs/aufs/si_XXX/brNNN.
Actually the file under sysfs has also a size limitation, but I don't
think it is harmful.

There is one more side effect in setting 1 to this parameter.
If you rename your branch, the branch path written in /etc/mtab will be
obsoleted and the future remount will meet some error due to the
unmatched parameters (Remember that mount(8) may take the options from
/etc/mtab and pass them to the systemcall).
If you set 1, /etc/mtab will not hold the branch path and you will not
meet such trouble. On the other hand, the entries for the
branch path under sysfs are generated dynamically. So it must not be obsoleted.
But I don't think users want to rename branches so often.

If CONFIG_SYSFS is disable, this parameter is always set to 0.
----------------------------------------------------------------------


If you post the details of your environment to aufs-users ML, then I
may be able to describe more.


J. R. Okajima
