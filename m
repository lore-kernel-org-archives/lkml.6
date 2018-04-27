Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeD0XYP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:24:15 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35815 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeD0XYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:24:12 -0400
X-Google-Smtp-Source: AB8JxZqoFXXeA2ygksTNkCUZI3dbxuIBukGTL2mctakylwzVWWPol1mtk101RPZtyL3O53xn6NPqThZRvGrOu2hbQtY=
MIME-Version: 1.0
In-Reply-To: <20180427215449.GA133494@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org> <20180419221635.17849-6-ilina@codeaurora.org>
 <20180425214111.GC243180@google.com> <20180427173943.GD6380@codeaurora.org>
 <20180427184017.GI243180@google.com> <20180427194559.GE6380@codeaurora.org>
 <20180427200605.GJ243180@google.com> <20180427213201.GA23157@codeaurora.org> <20180427215449.GA133494@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 27 Apr 2018 16:24:10 -0700
X-Google-Sender-Auth: XQV7HsJrGQGNCXimyF1DhJ-b1g0
Message-ID: <CAD=FV=Wan0G_GG29Q-atBbQS+_7nnbqTndE+yyi_G=scOdGMFA@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Lina Iyer <ilina@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 27, 2018 at 2:54 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > Am I getting something wrong here?
>>
>> The for_each_set_bit() should increment the 'i' and we would attempt to
>> compare the first address in the request with the next command in the
>> TCS cache. If they don't match we repeat the process again. If it does,
>> then we loop through 'j' to find if the sequence matches.
>>
>> Did I miss something?
>
> One of us is clearly in need of more caffeine or ready for the
> weekend, it might be me :) Maybe another pair of eyeballs could help
> to resolve this deadlock ...
>
> My single stepping above assumes that tcs->cmd_cache[i] matches
> cmd[0].addr, i.e. we either found the start of the sequence we are
> looking for or another sequence that starts with the same address. My
> claim is that the code returns i in either case, whether the
> subsequent addresses match or not.

I haven't reviewed this patch in detail, but I attempted to be another
pair of eyes here.  Something is definitely wrong with the "for (j =
0; j < len; j++)" loop.  I believe the code that's written right now
is equivalent to this much shorter function:

+static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
+                     int len)
+{
+       int i, j;
+
+       /* Check for already cached commands */
+       for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
+               if (tcs->cmd_cache[i] == cmd[0].addr)
+                       return i;
+       }
+
+       return -ENODATA;
+}

Specifically the test "if (tcs->cmd_cache[i] != cmd[0].addr)" does not
take "j" into account.  Thus if it was false when "j == 0" it will
continue to be false for "j == 1", "j == 2", etc.  Eventually you'll
hit the "else if (j == len - 1)" and return.

I believe that's what Matthias has been saying.  I personally haven't
looked at the rest of the patch to see how things out to be fixed, but
I'm quite convinced that the function either has a bug or should be
written as the shorter version I've written above.

-Doug
