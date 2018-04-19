Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+T8epQHDkea6ns5tpbMEyGf7Hep2nl0zxEqPeNbmgc3MgB1pveznEOK7FG1idxanzglhIT
ARC-Seal: i=1; a=rsa-sha256; t=1524135882; cv=none;
        d=google.com; s=arc-20160816;
        b=UTS9djkfzpr3iD66DoJdM5T/KQRal+TgG1Bm+JscuZOCk5qNpd5XZGnzyKYIp8XKXM
         mWbxAbLXLXmEKQpRP6SP9OBcZLr3gqilE/fa4KfOsPj9X9kn6eGydN3iwsYQWNlnarIw
         rYHGErwc34RgqimEwKdLkQnF19ztT6SZN+5oA6yNfpfRUybX2+R+IVgvdmSGHlBNTF/Z
         efeCkVJydzCiSMlM5jWj7GCc5rhaqF9rG6wLyAb6cxO1VwDWAzXHSh7ERkq7WDBuSHwG
         ojkZ7TtqkOAMhs0nyEL0Sv4NpJ8qptNWc/1Ubks+POwx+q9Vsf+GIKakpR7nM2gO5tgV
         L3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=LijawDXfA+hMBjvR5MD5NnFK9lLpyb6Kyem3aWCUGbA=;
        b=wGAWvu8r5gRFk9lYK/k9rKDxhU+DgsR7qE7xxaup49A8dbGFMfGGO8oh/aDyDwqZmZ
         sOf3kp1pkUWZjLyjKayvHLHGgUtoeVQomDOhM94cFqntzfQNrNlzFLVs7kHO3pZbWjKN
         WQUtXyGgXccW5eH4H0i4n2jafeduU2ApMEFPcn3IezqIxR2IWjiWfSSLAgvOQCPW3Qcz
         t/CYU9qvtIXJtpEAtsAS3qVTe8XO+/zfsOFJcn6ppb0i9Fto0mNTGzXuMgaMhKHNIhaf
         Jxb+iWooZuE1OPt0r/7gWl6ZdxILR5y67DsIR/srbTn0V7BoR9GrsE7XJADWeKv2B0IJ
         lzrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SHNSNUHh;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SHNSNUHh;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.78 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3JB42uq024223
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/2] usb: dwc3: support clocks and resets for DWC3 core
Date: Thu, 19 Apr 2018 20:03:36 +0900
Message-Id: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172301797892822?=
X-GMAIL-MSGID: =?utf-8?q?1598172307112907244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the current design of DWC3 driver,
the DT typically becomes a nested structure like follows:

  dwc3-glue {
          compatible = "foo,dwc3";
          ...

          dwc3 {
                  compatible = "snps,dwc3";
                  ...
          };
  }

The current DWC3 core (drivers/usb/dwc3/core.c) can not handle
clocks / resets at all.

The only solution we have now, is to put DWC3 core node under
the glue layer node, then add clocks and resets there.
Actually, dwc3-of-simple.c exists to handle clocks and resets.

As always for digital circuits, DWC3 core IP itself needs clock input.
This is specific to this IP.  So, supporting clocks and resets in
dwc3/core.c makes sense.

In this version, the number of clocks (and names) is specific
to this IP, with clock names taken from Synopsys datasheet.


Masahiro Yamada (2):
  usb: dwc3: use local copy of resource to fix-up register offset
  usb: dwc3: support clocks and resets for DWC3 core

 Documentation/devicetree/bindings/usb/dwc3.txt |  21 +++++
 drivers/usb/dwc3/core.c                        | 119 +++++++++++++++++++------
 drivers/usb/dwc3/core.h                        |   8 ++
 3 files changed, 123 insertions(+), 25 deletions(-)

-- 
2.7.4
