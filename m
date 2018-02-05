Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeBEQec (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:34:32 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:39285 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeBEQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:34:24 -0500
X-Google-Smtp-Source: AH8x224EPb/uN22Y911FpPZkXLq/CxGGBLUtJogam0gnQ0eeRDOo/7Rm/PwgYQPSezL+sSsDWlp9fRQqXjYpYVJ6xEw=
MIME-Version: 1.0
In-Reply-To: <20180202232923.GK12728@builder>
References: <a2a6bf12-529c-cb20-c69f-106d34e1204a@st.com> <e804928d-deb9-668a-7012-2843ba85285e@st.com>
 <CAK8P3a36Kqh-qscU0vsKH00ReXKk8HOYzzhbt6SxAoEBvPYuig@mail.gmail.com> <20180202232923.GK12728@builder>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 17:34:23 +0100
X-Google-Sender-Auth: afqDkJLhDX4DUXlcwdv3HgutbOc
Message-ID: <CAK8P3a0ozf=7shwM=kq9qqX_Tt6XxzfV=HqjZoTZ46xc1Gvg8g@mail.gmail.com>
Subject: Re: Compilation error report for: drivers/firmware/qcom_scm.c:469:47:
 error: passing argument 3 of ?dma_alloc_coherent? from incompatible pointer type
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "Andy Gross <andy.gross@linaro.org> , David Brown"
        <david.brown@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 12:29 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 30 Jan 05:25 PST 2018, Arnd Bergmann wrote:
>
>> On Tue, Jan 30, 2018 at 11:11 AM, Benjamin GAIGNARD
>> <benjamin.gaignard@st.com> wrote:
>> >
>> > On 01/12/2018 05:11 PM, Arnaud Pouliquen wrote:
>> >> Hello Andy,David,
>> > + Arnd
>> >
>> > I have the same issue on drm-misc-next.
>> > Does Arnaud's fix make sense or should we update/change the way of how
>> > we compile the kernel ?
>>
>> We've hit a couple of bugs with qcom drivers confusing physical addresses
>> and DMA addresses in the past, usually the drivers were buggy in
>> some form, and tried to use dma_alloc_coherent() to get a buffer
>> that gets passed into a firmware interface taking a physical address,
>> which is of course completely wrong.
>>
>
> Thanks Arnd, for once again using the words "bug" and "completely wrong"
> when referring to something that obviously works just fine...

Sorry, you are right my choice of words was uncalled for. I
was getting carried away after seeing Arnaud's suggestion
for changing the variable type but not the name, and got
carried away.

> The solution you introduced for venus and adreno relies on static
> reservations of system ram, which isn't pretty, but more importantly
> isn't viable for the qcom_scm driver.
>
>
> So, how do I dynamically allocate a chunk of coherent memory?
>
> Preferably with the possibility of unmapping it temporarily from Linux
> while passing the buffer into the trusted environment (as any accesses
> during the operation might cause access violations).

Well, there is a fundamental problem here that 'coherent memory'
as such does not exist. The DMA mapping interface is meant to
guarantee coherency between a pair of bus masters, i.e. a CPU
and a device, in a way that is a specific to that pair, without the
driver having to worry about the details.

What the qcom_scm driver does here is to approximate the behavior
it needs by calling the dma mapping interfaces. It happens to work
some of the time, but it's really something else as we are talking
to firmware here and it doesn't have the same semantics that the
dma mapping code provides.

I think what we want here is to come up with a new allocator that
matches the requirements of SCM and that doesn't use dma_addr_t.

For allocating memory that can be unmapped, I think the low-level
CMA allocation can work, which would also make it independent
of the device we are allocating for. Can you say what exactly the
requirements are on the memory buffer? I assume you don't really
want uncached memory, but instead want a buffer that gets flushed
to physical memory before you pass it down so you don't get
a writeback to memory that is inaccessible by the OS, correct?

      Arnd
