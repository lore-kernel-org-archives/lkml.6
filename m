Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755547AbeBOTg7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:36:59 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41531 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755533AbeBOTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:36:57 -0500
X-Google-Smtp-Source: AH8x224d09ps3WRCZKpSsDbJ0ueM0VHx3vyz+kjcG5NE908asUULkZa8PIAE2wRCdf1DWyiOo3ytfAuhyjUlX1IbnI0=
MIME-Version: 1.0
References: <20170807195027.13192-1-mjg59@google.com> <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
 <20180215152514.rxmh7webdg2i2fct@redbean>
In-Reply-To: <20180215152514.rxmh7webdg2i2fct@redbean>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 15 Feb 2018 19:36:45 +0000
Message-ID: <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures configurable
To: Jessica Yu <jeyu@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 7:25 AM Jessica Yu <jeyu@kernel.org> wrote:
> I'm still unclear on why a distro would enable CONFIG_MODULE_SIG and
> then _not_ want to know about unsigned modules.

The same kernel image may be used in situations where the use case benefits
from enforcement of module signatures and cases where it doesn't -
distributions don't generally have the resources to ship multiple kernel
packages with lightly modified configurations.

>  From what I understand from Ben's post from last year
> (http://lkml.kernel.org/r/1504044122.4448.24.camel@decadent.org.uk),
> it sounds like the main issue is that Debian doesn't support their own
> centralised module signing yet, causing all of their modules to be
> automatically tainted if they enable CONFIG_MODULE_SIG, and that a new
> option like this would likely be used as a temporary "fix". Am I
> understanding correctly?

Not entirely. There's two cases where the current situation causes problems:

1) Distributions that build out of tree kernel modules and don't have
infrastructure to sign them will end up with kernel taint. That's something
that can be resolved by implementing that infrastructure.
2) End-users who build out of tree kernel modules will end up with kernel
taint and will file bugs. This cannot be fixed but will increase
distribution load anyway.

> I understand this predicament, but it seems like adding a new set of
> options/parameters like this is just hiding the symptoms of the
> problem (modules distributed by Debian getting tainted by default)
> instead of fixing what seems to be the heart of the issue (Debian
> doesn't support their own module signing yet), if that makes sense.
> I am hesitant about merging something that would only serve as a
> temporary solution until Debian supports their own module signing. In
> that case, I would prefer the Debian folks to maintain their own patch
> removing the taint until they support module signing for their own
> modules, especially if - and please correct me if I'm wrong - the
> new option is not going to see long-term usage.

I'd expect this option to be used by distributions for as long as
distributions need to support use-cases that don't need signed modules, so
probably forever.
