Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A2D27FFC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A2D27FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936510AbeF2OvJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:51:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49894 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936445AbeF2OvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:51:07 -0400
Received: from [192.168.1.110] ([77.190.97.101]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0M0vAh-1gQbcV3eLn-00v3i6 for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018
 16:51:04 +0200
To:     LKML <linux-kernel@vger.kernel.org>
From:   Enrico Weigelt <lkml@metux.net>
Subject: RFC: inlining device register accesses
Organization: metux IT consult
Message-ID: <af2d96b9-cc07-3bd0-abe2-585638096b9d@metux.net>
Date:   Fri, 29 Jun 2018 16:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BPZyFo2jzWqOzsIWXmR6fD2vvUxAMmT3gzeLyuji8XVqHa+rosa
 GmtqwNKgdsfDkPhzplGcJcbl+wBdpKwCa5R5uNf0GiP57SiFYFK90uIjaVm70/pr6dfwxRE
 BWOiqicXqLZyz1K++VFO6THtShPREwPUHE02U5q8KG96YGJeyLEghytlEU9topA9p0vfaUl
 nmmFBWfdepg4EaTG+unKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b7slXS4BjA8=:PyJeo+yg9YcoEcPD/qfcNx
 j9Q4yNzlH05z0nTkpl7Z1Noi+hJJnFkt6MTpGMwTjbFFe3Hblruq4LBmB7IKy23FCUaJ/l5cT
 XWlr+V4Bal75Z3UlkZyZIyAEHBupmVVJQ9FBZj3vMRBMxNREa+5L/O8iLe8ZKC7hV0kgpx+PK
 vZnDjqwENIBoVtP4XCB/QchtxhxDBx6geU+dNypf4nAceBjuErQy570yf421eUKWgofXGrmMb
 v2wcpq0v7vQOE0DZbbDufP7DSSjvC3JkgUsVG3F8mVHCqO6jfj55c844L+4Bkn5RIeze2HPic
 e1zcVFi/J3V3ikGHKCq56edYTcWv5bcK57vrfjBO78Hy9RR2UWj46VyiUUwEpFEjJT+nbt0lU
 /dBYRzYGO1abFI63n5t75Pgq+Td96eCKrgYZwj4Gc81KSWWyaqQOZeKrNQwovm1ug8YtTZjuw
 KkEVaiD2/Od6gM21TY1mXCRZscPTn8uKjfa5pw8oXUxm/KSL7i9vphj4SoHWoemo8dZr1luiS
 fXaqPZEsKf/RIpfzbQ1H+166YRxUt/As4I58AjMd4edCvo8p31gt9MTsJCbPF4xDh147FQ0wi
 RC0zXJxnpbve8HvTA/UKAtevhPkHx2IuoBHCYmz9mza+43mgAzDOTVgn7Jmroo9Kso+UGl36Q
 705wSUi7nyDpeK3heVXZCpvKhmeasO7oco61LepWP8OZEoyu5FxREvyEZAhl7R8lXQ4OiVNRQ
 iRUmOiYBbL86U9mJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've got a weird idea, that I'd like to hear your oppinion about:

In drivers we have lots of cases, where things like register accesses
sometimes (on specific boards+cpus) *could* be done by direct memory
access, while many times we need more complex operations, like talking
to an I2C controller. Certainly, we dont wanna have lots of different
bus-specific code pathes in the drivers - same issue as why regmap
has been invented.

Maybe we could declare the actual register access in a more abstract
way (macros ? dsl ?), so under the hood different code pathes can be
generated and picked dynamically via kprobes-alike approach. If the
device happens to be directly cpu-accessible, ops for direct memory
access are inserted, otherwise appropriate function calls. Or maybe
the bpf jit somehow could be abused for that ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
